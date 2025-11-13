// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/*
    STOPWARTOKEN (SWT)
    -----------------------------------------------------------------------
    Transparent Humanitarian Token on Polygon (POL).

    - Fixed supply: 1,000,000 SWT
    - Humanitarian fee: 0.1% (10 bps) on transfers by default
    - Fee can only be reduced (min 0.05%), never increased
    - Fee routed to contract balance and swapped to USDT on triggerCharity()
    - Additional donation flow: contract can accept selected tokens and
      swap them to USDT for the humanitarian multisig wallet
    - No minting, no ownership transfer, no proxy, no upgradeability
    - Owner & Reserve wallets are time-locked
    - Dev, Airdrop, Marketing wallets have strict on-chain limits
    - LP interactions: pools detected automatically (Uniswap V3 + QuickSwap)

    NOTE:
    This is the commented GitHub version of the contract. The verified
    Polygonscan source has the same logic but may be more compact and
    without extended comments.
*/

/*//////////////////////////////////////////////////////////////////////////
                                EXTERNAL INTERFACES
//////////////////////////////////////////////////////////////////////////*/

/// @notice Minimal Uniswap V3 factory interface (for pool discovery)
interface IUniswapV3Factory {
    function getPool(address tokenA, address tokenB, uint24 fee)
        external
        view
        returns (address pool);
}

/// @notice Minimal Algebra/QuickSwap factory interface (for pool discovery)
interface IAlgebraFactory {
    function poolByPair(address tokenA, address tokenB)
        external
        view
        returns (address pool);
}

/// @notice Uniswap V3 Quoter interface for off-chain / on-chain quoting
interface IQuoter {
    function quoteExactInput(bytes memory path, uint256 amountIn)
        external
        returns (uint256 amountOut);
}

/// @notice Uniswap V3 SwapRouter interface (ExactInput path-based swaps)
interface ISwapRouter {
    struct ExactInputParams {
        bytes path;
        address recipient;
        uint256 deadline;
        uint256 amountIn;
        uint256 amountOutMinimum;
    }

    function exactInput(ExactInputParams calldata params)
        external
        payable
        returns (uint256 amountOut);
}

/// @notice Minimal ERC20 interface used for external token operations
interface IERC20 {
    function transfer(address to, uint256 value) external returns (bool);

    function balanceOf(address account) external view returns (uint256);

    function approve(address spender, uint256 amount)
        external
        returns (bool);

    function transferFrom(address from, address to, uint256 value)
        external
        returns (bool);
}

/*//////////////////////////////////////////////////////////////////////////
                                   CONTRACT
//////////////////////////////////////////////////////////////////////////*/

contract STOPWARTOKEN {
    /*======================================================================
                                ERC-20 METADATA
    ======================================================================*/

    /// @notice Token name
    string public constant name = "STOPWARTOKEN";

    /// @notice Token symbol
    string public constant symbol = "SWT";

    /// @notice Token decimals (18, standard ERC-20)
    uint8 public constant decimals = 18;

    /// @notice Total token supply (1,000,000 * 10^18)
    uint256 private _totalSupply;

    /// @notice Basic ERC-20 balances mapping
    mapping(address => uint256) private _balances;

    /// @notice ERC-20 allowance mapping
    mapping(address => mapping(address => uint256)) private _allowances;

    /*======================================================================
                              OWNERSHIP & MODIFIERS
    ======================================================================*/

    /// @notice Contract deployer / logical owner (controls dev parameters)
    address public immutable owner;

    /// @notice Restricts function to contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "NOT_OWNER");
        _;
    }

    /// @notice Simple nonReentrant guard (no external calls re-entering)
    modifier nonReentrant() {
        require(_status != _ENTERED, "REENTRANT_CALL");
        _status = _ENTERED;
        _;
        _status = _NOT_ENTERED;
    }

    /*======================================================================
                            PROJECT WALLETS (IMMUTABLE)
    ======================================================================*/

    /// @notice Long-term owner wallet (locked until OWNER_UNLOCK)
    address public immutable ownerWallet =
        0x2592e0F33277f8587D7824f0167B169071De88EF;

    /// @notice Development wallet (subject to daily spend limit)
    address public immutable devWallet =
        0xA812c815d900D6bbd60EA571C172342721Edf62C;

    /// @notice Liquidity provider wallet (manages LP positions)
    address public immutable liquidityWallet =
        0x1b33ef5b34e1881006897F504Adc95eFa41b5011;

    /// @notice Airdrop wallet (subject to weekly spend limit)
    address public immutable airdropWallet =
        0xf6ED37Cf4ce114e801803123040e33288878c443;

    /// @notice Marketing wallet (subject to monthly spend limit & no-contract rule)
    address public immutable marketingWallet =
        0x66fadd1a35268A2d20Fe95e678C7859250a3F491;

    /// @notice Reserve wallet (time-locked, cannot be used before RESERVE_UNLOCK)
    address public immutable reserveWallet =
        0xdfEbb436bb8F6067F0661178057eDEE9B3Ff26D9;

    /// @notice Humanitarian multisig admin (2/2 multisig, off-chain structure)
    address public immutable charityAdmin =
        0xe790Ef3b365f9a7E2f3E901B3c60199b3704C29a;

    /*======================================================================
                    HUMANITARIAN FEE CONFIGURATION & PARAMETERS
    ======================================================================*/

    /// @notice Humanitarian fee in basis points (10 = 0.1%)
    /// @dev Can only be reduced (min 5 bps = 0.05%), never increased.
    uint16 public FEE_BASIS = 10;

    /// @notice Basis points denominator (10000 = 100.00%)
    uint16 public constant BP_DENOM = 10000;

    /// @notice Minimum SWT balance on contract before charity trigger can be called
    uint256 public charityThreshold = 50 * 10 ** 18;

    /// @notice SWT bounty amount for users who call triggerCharity/triggerDonation
    uint256 public bountyAmount = 5 * 10 ** 18;

    /// @notice Default slippage (basis points) for swaps (2% default)
    uint16 public slippageBps = 200;

    /// @notice Uniswap V3 fee tiers used for route discovery (0.01%, 0.05%, 0.3%)
    uint24[3] internal FEES = [100, 500, 3000];

    /// @notice Cached best swap paths for tokenIn -> USDT
    mapping(address => bytes) public bestPaths;

    /*======================================================================
                         EXTERNAL PROTOCOL CONTRACTS (IMMUTABLE)
    ======================================================================*/

    /// @notice Uniswap V3 Quoter (Polygon)
    IQuoter public immutable quoter =
        IQuoter(0xb27308f9F90D607463bb33eA1BeBb41C27CE5AB6);

    /// @notice Uniswap V3 SwapRouter (Polygon)
    ISwapRouter public immutable swapRouter =
        ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564);

    /// @notice Uniswap V3 Factory (Polygon)
    IUniswapV3Factory public immutable uniswapFactory =
        IUniswapV3Factory(0x1F98431c8aD98523631AE4a59f267346ea31F984);

    /// @notice Algebra/QuickSwap Factory (Polygon)
    IAlgebraFactory public immutable quickswapFactory =
        IAlgebraFactory(0x411b0fAcC3489691f28ad58c47006AF5E3Ab3A28);

    /// @notice Uniswap V3 NFT positions manager (for LP NFTs)
    address public immutable UNISWAP_V3_NFT_MANAGER =
        0xC36442b4a4522E871399CD717aBDD847Ab11FE88;

    /// @notice QuickSwap NFT positions manager (Algebra)
    address public immutable QUICKSWAP_NFT_MANAGER =
        0x8eF88E4c7CfbbaC1C163f7eddd4B578792201de6;

    /*======================================================================
                         CORE ERC20 ADDRESSES (STABLES / WRAPPED)
    ======================================================================*/

    /// @notice Polygon USDT (stablecoin)
    address public immutable USDT =
        0xc2132D05D31c914a87C6611C10748AEb04B58e8F;

    /// @notice Polygon USDC (stablecoin)
    address public immutable USDC =
        0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359;

    /// @notice Polygon WETH
    address public immutable WETH =
        0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619;

    /// @notice Polygon WBTC
    address public immutable WBTC =
        0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6;

    /*======================================================================
                           FEE EXCLUSIONS & POOL DETECTION
    ======================================================================*/

    /// @notice Tracks addresses that are known LP pools (Uniswap/QuickSwap)
    mapping(address => bool) public isPool;

    /// @notice Fee exclusion list (no humanitarian fee applied to these addresses)
    mapping(address => bool) public isExcludedFromFee;

    /// @notice Whitelist of donation tokens the contract can accept and swap
    mapping(address => bool) public donationWhitelist;

    /// @notice Global switch to enable/disable donation flow (triggerDonation)
    bool public donationEnabled = false;

    /*======================================================================
                        TIME-LOCK & SPENDING LIMITS CONFIG
    ======================================================================*/

    /// @notice Global unlock timestamp for ownerWallet
    uint256 public OWNER_UNLOCK = 1798761600; // 2027-01-01 UTC

    /// @notice Global unlock timestamp for reserveWallet
    uint256 private constant RESERVE_UNLOCK = 1798761600; // 2027-01-01 UTC

    /// @notice Max daily spend from devWallet
    uint256 private constant DEV_DAILY_LIMIT = 10_000 * 10 ** 18;

    /// @notice Max weekly spend from airdropWallet
    uint256 private constant AIRDROP_WEEKLY_LIMIT = 25_000 * 10 ** 18;

    /// @notice Max monthly spend from marketingWallet
    uint256 private constant MARKETING_MONTHLY_LIMIT = 20_000 * 10 ** 18;

    /// @notice Per-address daily spend tracking (for devWallet)
    mapping(address => uint256) private _spentDay;
    mapping(address => uint256) private _lastDay;

    /// @notice Per-address weekly spend tracking (for airdropWallet)
    mapping(address => uint256) private _spentWeek;
    mapping(address => uint256) private _lastWeek;

    /// @notice Per-address monthly spend tracking (for marketingWallet)
    mapping(address => uint256) private _spentMonth;
    mapping(address => uint256) private _lastMonth;

    /*======================================================================
                            REENTRANCY GUARD INTERNALS
    ======================================================================*/

    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;
    uint256 private _status = _NOT_ENTERED;

    /*======================================================================
                                   EVENTS
    ======================================================================*/

    /// @notice Standard ERC-20 Transfer event
    event Transfer(address indexed from, address indexed to, uint256 value);

    /// @notice Standard ERC-20 Approval event
    event Approval(address indexed owner_, address indexed spender, uint256 value);

    /// @notice Emitted when USDT is sent from the contract to a charity wallet
    event CharityUSDTTransfer(address indexed to, uint256 amount);

    /// @notice Emitted when the humanitarian fee is reduced
    event CharityFeeReduced(uint16 oldFee, uint16 newFee);

    /// @notice Emitted whenever a donation swap to USDT is executed
    event DonationSwapped(
        address indexed caller,
        address tokenIn,
        uint256 amountIn,
        uint256 usdtOut
    );

    /// @notice Emitted when a manual swap (owner-only) is executed
    event ManualSwapExecuted(address indexed tokenIn, uint256 amountIn, uint256 amountOut);

    /// @notice Emitted when a bounty is sent to a caller
    event BountySent(address indexed caller, uint256 amount);

    /// @notice Emitted when bountyAmount is updated
    event BountyUpdated(uint256 oldValue, uint256 newValue);

    /// @notice Emitted when charityThreshold is updated
    event CharityThresholdUpdated(uint256 oldValue, uint256 newValue);

    /// @notice Emitted when slippageBps is updated
    event SlippageUpdated(uint16 oldValue, uint16 newValue);

    /// @notice Emitted when a wallet is locked until a given timestamp
    event WalletLocked(address indexed wallet, uint256 until);

    /// @notice Emitted when dev wallet daily limit is used
    event DailyLimitUsed(address indexed wallet, uint256 used, uint256 remaining);

    /// @notice Emitted when airdrop wallet weekly limit is used
    event WeeklyLimitUsed(address indexed wallet, uint256 used, uint256 remaining);

    /// @notice Emitted when marketing wallet monthly limit is used
    event MonthlyLimitUsed(address indexed wallet, uint256 used, uint256 remaining);

    /*======================================================================
                                 CONSTRUCTOR
    ======================================================================*/

    constructor() {
        owner = msg.sender;

        uint256 d = 10 ** decimals;

        // Mint total supply to project wallets according to tokenomics
        _mint(ownerWallet, 50_000 * d);
        _mint(liquidityWallet, 500_000 * d);
        _mint(reserveWallet, 200_000 * d);
        _mint(devWallet, 100_000 * d);
        _mint(marketingWallet, 50_000 * d);
        _mint(airdropWallet, 100_000 * d);

        // Sanity check: ensure total supply is exactly 1,000,000 SWT
        require(_totalSupply == 1_000_000 * d, "BAD_SUPPLY");

        // Exclude project wallets and core contracts from humanitarian fee
        isExcludedFromFee[ownerWallet] = true;
        isExcludedFromFee[devWallet] = true;
        isExcludedFromFee[liquidityWallet] = true;
        isExcludedFromFee[airdropWallet] = true;
        isExcludedFromFee[marketingWallet] = true;
        isExcludedFromFee[reserveWallet] = true;
        isExcludedFromFee[address(this)] = true;
        isExcludedFromFee[UNISWAP_V3_NFT_MANAGER] = true;
        isExcludedFromFee[QUICKSWAP_NFT_MANAGER] = true;

        // Pre-approve core donation tokens
        donationWhitelist[USDT] = true;
        donationWhitelist[USDC] = true;
        donationWhitelist[WETH] = true;
        donationWhitelist[WBTC] = true;

        // Emit time-lock events for transparency
        emit WalletLocked(ownerWallet, OWNER_UNLOCK);
        emit WalletLocked(reserveWallet, RESERVE_UNLOCK);
    }

    /*======================================================================
                           ERC-20 VIEW FUNCTIONS
    ======================================================================*/

    /// @notice Returns total supply of SWT
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /// @notice Returns SWT balance of an account
    function balanceOf(address a) public view returns (uint256) {
        return _balances[a];
    }

    /// @notice Returns allowance from owner to spender
    function allowance(address o, address s) public view returns (uint256) {
        return _allowances[o][s];
    }

    /*======================================================================
                              ERC-20 WRITE FUNCTIONS
    ======================================================================*/

    /// @notice Approve spender to spend tokens on behalf of msg.sender
    function approve(address s, uint256 a) external returns (bool) {
        _allowances[msg.sender][s] = a;
        emit Approval(msg.sender, s, a);
        return true;
    }

    /// @notice Transfer tokens to another address
    function transfer(address to, uint256 amt) external returns (bool) {
        _transfer(msg.sender, to, amt);
        return true;
    }

    /// @notice Transfer tokens on behalf of another address (requires allowance)
    function transferFrom(address from, address to, uint256 amt)
        external
        returns (bool)
    {
        uint256 a = _allowances[from][msg.sender];
        require(a >= amt, "ALLOWANCE");
        _allowances[from][msg.sender] = a - amt;
        _transfer(from, to, amt);
        return true;
    }

    /*======================================================================
                         INTERNAL MINT (CONSTRUCTOR ONLY)
    ======================================================================*/

    /// @dev Internal mint used only in constructor
    function _mint(address to, uint256 amt) internal {
        require(to != address(0), "ZERO_ADDRESS");
        _totalSupply += amt;
        _balances[to] += amt;
        emit Transfer(address(0), to, amt);
    }

    /*======================================================================
                         POOL DETECTION (UNISWAP / QUICKSWAP)
    ======================================================================*/

    /**
     * @dev Detects whether `addr` is a known liquidity pool for (tokenA, tokenB)
     *      on either QuickSwap (Algebra) or Uniswap V3 (set of fee tiers).
     *      Caches discovered pools in `isPool` to avoid repeated lookups.
     */
    function _isPool(address addr, address tokenA, address tokenB)
        internal
        returns (bool)
    {
        if (isPool[addr]) return true;

        // QuickSwap (Algebra) pool lookup
        address qsPool = quickswapFactory.poolByPair(tokenA, tokenB);
        if (addr == qsPool && qsPool != address(0)) {
            isPool[qsPool] = true;
            return true;
        }

        // Uniswap V3 pool lookup across configured fee tiers
        for (uint256 i = 0; i < FEES.length; i++) {
            address uniPool = uniswapFactory.getPool(tokenA, tokenB, FEES[i]);
            if (addr == uniPool && uniPool != address(0)) {
                isPool[uniPool] = true;
                return true;
            }
        }
        return false;
    }

    /*======================================================================
                        CORE TRANSFER + FEE + LIMIT LOGIC
    ======================================================================*/

    /**
     * @dev Core transfer with:
     * - time-lock checks for owner & reserve wallets
     * - daily/weekly/monthly limits for dev/airdrop/marketing wallets
     * - humanitarian fee routing to contract balance
     * - LP/pool detection to avoid double-charging DEX interactions
     */
    function _transfer(address from, address to, uint256 amt) internal {
        require(from != address(0) && to != address(0), "ZERO_ADDRESS");
        require(_balances[from] >= amt, "INSUFFICIENT_BALANCE");

        // --- Time locks for long-term wallets ---
        if (from == ownerWallet) {
            require(block.timestamp >= OWNER_UNLOCK, "OWNER_LOCKED");
        }
        if (from == reserveWallet) {
            require(block.timestamp >= RESERVE_UNLOCK, "RESERVE_LOCKED");
        }

        // --- Dev wallet daily limit ---
        if (from == devWallet) {
            uint256 day = block.timestamp / 1 days;
            if (day > _lastDay[from]) {
                _spentDay[from] = 0;
                _lastDay[from] = day;
            }
            require(
                _spentDay[from] + amt <= DEV_DAILY_LIMIT,
                "DEV_DAILY_LIMIT"
            );
            _spentDay[from] += amt;
            emit DailyLimitUsed(
                from,
                _spentDay[from],
                DEV_DAILY_LIMIT - _spentDay[from]
            );
        }

        // --- Airdrop wallet weekly limit ---
        if (from == airdropWallet) {
            uint256 week = block.timestamp / 7 days;
            if (week > _lastWeek[from]) {
                _spentWeek[from] = 0;
                _lastWeek[from] = week;
            }
            require(
                _spentWeek[from] + amt <= AIRDROP_WEEKLY_LIMIT,
                "AIRDROP_WEEKLY_LIMIT"
            );
            _spentWeek[from] += amt;
            emit WeeklyLimitUsed(
                from,
                _spentWeek[from],
                AIRDROP_WEEKLY_LIMIT - _spentWeek[from]
            );
        }

        // --- Marketing wallet monthly limit and "no contracts" rule ---
        if (from == marketingWallet) {
            // Marketing cannot send directly to contracts (to avoid opaque deals)
            require(to.code.length == 0, "NO_CONTRACTS");

            uint256 month = block.timestamp / 30 days;
            if (month > _lastMonth[from]) {
                _spentMonth[from] = 0;
                _lastMonth[from] = month;
            }
            require(
                _spentMonth[from] + amt <= MARKETING_MONTHLY_LIMIT,
                "MARKETING_MONTHLY_LIMIT"
            );
            _spentMonth[from] += amt;
            emit MonthlyLimitUsed(
                from,
                _spentMonth[from],
                MARKETING_MONTHLY_LIMIT - _spentMonth[from]
            );
        }

        // --- Humanitarian fee calculation ---
        uint256 fee = 0;

        bool exempt =
            isExcludedFromFee[from] ||
            isExcludedFromFee[to] ||
            _isPool(from, address(this), USDT) ||
            _isPool(to, address(this), USDT);

        if (!exempt) {
            fee = (amt * FEE_BASIS) / BP_DENOM;
        }

        // --- Balance updates ---
        unchecked {
            _balances[from] -= amt;
            uint256 received = amt - fee;
            _balances[to] += received;
            emit Transfer(from, to, received);

            if (fee > 0) {
                _balances[address(this)] += fee;
                emit Transfer(from, address(this), fee);
            }
        }
    }

    /*======================================================================
                     INTERNAL LOW-LEVEL APPROVE HELPER (SAFE)
    ======================================================================*/

    /**
     * @dev Safely sets allowance for a token, using reset-to-zero pattern
     *      to avoid issues with some ERC-20 implementations.
     */
    function _lowLevelApprove(
        address token,
        address spender,
        uint256 amount
    ) internal {
        // Reset allowance to 0 first
        (bool s1, bytes memory data1) =
            token.call(abi.encodeWithSelector(IERC20.approve.selector, spender, 0));
        require(
            s1 && (data1.length == 0 || abi.decode(data1, (bool))),
            "APPROVE_RESET_FAILED"
        );

        // Then set to requested amount
        (bool s2, bytes memory data2) =
            token.call(abi.encodeWithSelector(IERC20.approve.selector, spender, amount));
        require(
            s2 && (data2.length == 0 || abi.decode(data2, (bool))),
            "APPROVE_SET_FAILED"
        );
    }

    /*======================================================================
                     INTERNAL SWAP LOGIC (TOKEN -> USDT)
    ======================================================================*/

    /**
     * @dev Core swap helper for converting tokenIn -> USDT via Uniswap V3.
     *      Uses cached best path if available, otherwise discovers new route.
     *
     *      - Uses IQuoter to estimate output
     *      - Applies slippageBps as minOut protection
     *      - On router errors, attempts with 0 minOut (best-effort)
     *      - If best path fails, clears cache and tries direct routes
     */
    function _doSwapTokenToUSDT(address tokenIn, uint256 amountIn)
        internal
        returns (uint256)
    {
        require(amountIn > 0, "ZERO_AMOUNT");

        _lowLevelApprove(tokenIn, address(swapRouter), amountIn);

        // Try cached best path first (if length == 43 bytes)
        bytes memory path = bestPaths[tokenIn];
        if (path.length == 43) {
            try quoter.quoteExactInput(path, amountIn) returns (uint256 quotedOut) {
                if (quotedOut > 0) {
                    uint256 minOut =
                        (quotedOut * (10000 - slippageBps)) / 10000;

                    ISwapRouter.ExactInputParams memory params =
                        ISwapRouter.ExactInputParams({
                            path: path,
                            recipient: address(this),
                            deadline: block.timestamp + 300,
                            amountIn: amountIn,
                            amountOutMinimum: minOut
                        });

                    // Try with slippage protection
                    try swapRouter.exactInput(params)
                        returns (uint256 amountOut)
                    {
                        return amountOut;
                    } catch {
                        // Fallback: remove minOut, best-effort
                        params.amountOutMinimum = 0;
                        try swapRouter.exactInput(params)
                            returns (uint256 out2)
                        {
                            return out2;
                        } catch {
                            // If even best-effort fails, clear cached path
                            delete bestPaths[tokenIn];
                        }
                    }
                }
            } catch {
                // Quoter failed: clear cache
                delete bestPaths[tokenIn];
            }
        }

        // If no cached path or it failed — brute-force direct routes
        for (uint256 i = 0; i < FEES.length; i++) {
            bytes memory directPath =
                abi.encodePacked(tokenIn, FEES[i], USDT);

            try quoter.quoteExactInput(directPath, amountIn)
                returns (uint256 outDirect)
            {
                if (outDirect > 0) {
                    // Cache this path as best for tokenIn
                    bestPaths[tokenIn] = directPath;

                    uint256 minOutDirect =
                        (outDirect * (10000 - slippageBps)) / 10000;

                    ISwapRouter.ExactInputParams memory paramsDirect =
                        ISwapRouter.ExactInputParams({
                            path: directPath,
                            recipient: address(this),
                            deadline: block.timestamp + 300,
                            amountIn: amountIn,
                            amountOutMinimum: minOutDirect
                        });

                    // Try swap with slippage protection
                    try swapRouter.exactInput(paramsDirect)
                        returns (uint256 resultDirect)
                    {
                        return resultDirect;
                    } catch {
                        // Fallback: no minOut, best-effort
                        paramsDirect.amountOutMinimum = 0;
                        try swapRouter.exactInput(paramsDirect)
                            returns (uint256 resultDirect2)
                        {
                            return resultDirect2;
                        } catch {
                            revert("SWAP_FAILED_DIRECT");
                        }
                    }
                }
            } catch {
                // ignore and try next fee tier
            }
        }

        revert("NO_ROUTE_FOUND");
    }

    /*======================================================================
                       PUBLIC HUMANITARIAN FLOW FUNCTIONS
    ======================================================================*/

    /**
     * @notice Swaps accumulated SWT fee (if >= threshold) to USDT
     *         and keeps USDT in the contract (to later be moved via charityTransfer).
     *         Caller may receive a bounty in SWT from the airdrop wallet.
     */
    function triggerCharity() external nonReentrant {
        uint256 swtBal = _balances[address(this)];
        require(swtBal >= charityThreshold, "THRESHOLD");

        uint256 usdtOut = _doSwapTokenToUSDT(address(this), swtBal);
        emit DonationSwapped(msg.sender, address(this), swtBal, usdtOut);

        // Bounty reward in SWT from airdrop wallet
        if (_balances[airdropWallet] >= bountyAmount && bountyAmount > 0) {
            _balances[airdropWallet] -= bountyAmount;
            _balances[msg.sender] += bountyAmount;
            emit Transfer(airdropWallet, msg.sender, bountyAmount);
            emit BountySent(msg.sender, bountyAmount);
        }
    }

    /**
     * @notice Swaps accumulated whitelisted tokens (USDT, USDC, WETH, WBTC, etc.)
     *         held by the contract into USDT, keeping USDT inside the contract.
     *         Caller may receive a bounty in SWT from the airdrop wallet.
     */
    function triggerDonation(address token) external nonReentrant {
        require(donationEnabled, "DONATIONS_DISABLED");
        require(donationWhitelist[token], "TOKEN_NOT_WHITELISTED");

        uint256 bal = IERC20(token).balanceOf(address(this));
        require(bal > 0, "ZERO_BALANCE");

        uint256 usdtOut = _doSwapTokenToUSDT(token, bal);
        emit DonationSwapped(msg.sender, token, bal, usdtOut);

        // Bounty reward in SWT from airdrop wallet
        if (_balances[airdropWallet] >= bountyAmount && bountyAmount > 0) {
            _balances[airdropWallet] -= bountyAmount;
            _balances[msg.sender] += bountyAmount;
            emit Transfer(airdropWallet, msg.sender, bountyAmount);
            emit BountySent(msg.sender, bountyAmount);
        }
    }

    /**
     * @notice Owner-only manual swap helper (for handling rare edge cases)
     *         Swaps a chosen token held by the contract to USDT.
     */
    function manualSwap(address token, uint256 amount)
        external
        onlyOwner
        nonReentrant
    {
        require(amount > 0, "ZERO_AMOUNT");
        require(
            IERC20(token).balanceOf(address(this)) >= amount,
            "INSUFFICIENT_BALANCE"
        );

        uint256 usdtOut = _doSwapTokenToUSDT(token, amount);
        emit ManualSwapExecuted(token, amount, usdtOut);
        emit DonationSwapped(msg.sender, token, amount, usdtOut);
    }

    /**
     * @notice Transfers USDT from the contract to a humanitarian address.
     * @dev Can only be called by `charityAdmin` (2/2 multisig off-chain).
     */
    function charityTransfer(address to, uint256 amount)
        external
        nonReentrant
    {
        require(msg.sender == charityAdmin, "NOT_CHARITY_ADMIN");
        require(to != address(0), "ZERO_ADDRESS");

        (bool success, bytes memory data) =
            USDT.call(abi.encodeWithSelector(IERC20.transfer.selector, to, amount));
        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            "USDT_TRANSFER_FAILED"
        );

        emit CharityUSDTTransfer(to, amount);
    }

    /*======================================================================
                     FEE & CONFIGURATION (CHARITY ADMIN / OWNER)
    ======================================================================*/

    /**
     * @notice Reduces the humanitarian fee (in basis points).
     * @dev Only `charityAdmin` can call. New fee must be:
     *      - strictly lower than current FEE_BASIS
     *      - >= 5 (0.05%)
     */
    function reduceCharityFee(uint16 newFeeBasis) external {
        require(msg.sender == charityAdmin, "NOT_CHARITY_ADMIN");
        require(newFeeBasis < FEE_BASIS, "FEE_NOT_LOWER");
        require(newFeeBasis >= 5, "FEE_TOO_LOW");
        emit CharityFeeReduced(FEE_BASIS, newFeeBasis);
        FEE_BASIS = newFeeBasis;
    }

    /**
     * @notice Adds an address to fee-exempt list.
     * @dev Only `charityAdmin` can call.
     */
    function addExcludedFromFee(address newAddr) external {
        require(msg.sender == charityAdmin, "NOT_CHARITY_ADMIN");
        require(newAddr != address(0) && !isExcludedFromFee[newAddr], "BAD_ADDR");
        isExcludedFromFee[newAddr] = true;
    }

    /**
     * @notice Updates bountyAmount in SWT given to trigger callers.
     * @dev Only owner.
     */
    function setBounty(uint256 newAmount) external onlyOwner {
        emit BountyUpdated(bountyAmount, newAmount);
        bountyAmount = newAmount;
    }

    /**
     * @notice Updates charityThreshold (min SWT on contract before triggerCharity).
     * @dev Only owner.
     */
    function setCharityThreshold(uint256 newThreshold) external onlyOwner {
        require(newThreshold > 0, "ZERO_THRESHOLD");
        emit CharityThresholdUpdated(charityThreshold, newThreshold);
        charityThreshold = newThreshold;
    }

    /**
     * @notice Adds a token to donationWhitelist.
     * @dev Only owner. Token must be a valid ERC-20.
     */
    function addDonationToken(address token) external onlyOwner {
        require(token != address(0), "ZERO_ADDRESS");
        donationWhitelist[token] = true;
    }

    /**
     * @notice Removes a token from donationWhitelist.
     * @dev Only owner.
     */
    function removeDonationToken(address token) external onlyOwner {
        require(donationWhitelist[token], "NOT_WHITELISTED");
        donationWhitelist[token] = false;
    }

    /**
     * @notice Updates slippageBps (0–10%, i.e. 0–1000 bps).
     * @dev Only owner.
     */
    function setSlippageBps(uint16 newValue) external onlyOwner {
        require(newValue <= 1000, "SLIPPAGE_TOO_HIGH");
        emit SlippageUpdated(slippageBps, newValue);
        slippageBps = newValue;
    }

    /**
     * @notice Enables or disables donation flow (triggerDonation).
     * @dev Only owner.
     */
    function setDonationEnabled(bool enabled) external onlyOwner {
        donationEnabled = enabled;
    }

    /*======================================================================
                                VIEW HELPERS
    ======================================================================*/

    /// @notice SWT balance held by the contract (accumulated fees)
    function swtBalance() public view returns (uint256) {
        return _balances[address(this)];
    }

    /// @notice USDT balance held by the contract
    function usdtBalance() public view returns (uint256) {
        return IERC20(USDT).balanceOf(address(this));
    }

    /// @notice Balance of any token held by the contract
    function tokenBalance(address token) public view returns (uint256) {
        return IERC20(token).balanceOf(address(this));
    }
}
