// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title Uniswap V3 LP NFT Locker
 * @notice Trustless time-lock mechanism for Uniswap V3 LP position NFTs.
 *         - Only the original NFT owner can lock and later unlock the token.
 *         - Contract has no admin rights and no emergency withdrawal.
 *         - Works with NonfungiblePositionManager ERC721 implementation.
 *         - Multiple locks supported (one tokenId per lock).
 *
 * @dev NFT must be locked via `lockPosition()` and cannot be transferred manually.
 *      Address is set to Uniswap V3 NonfungiblePositionManager.
 */

interface IERC721 {
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
    function ownerOf(uint256 tokenId) external view returns (address);
}

interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}

contract UniswapV3LpNftLocker is IERC721Receiver {
    /// @notice Uniswap V3 NFT contract address
    IERC721 public immutable lpNft;

    struct LockInfo {
        address owner;    
        uint64 unlockTime;
        bool active;
    }

    struct PendingLock {
        address owner;      
        uint64 unlockTime;
    }

    mapping(uint256 => LockInfo) public locks;
    mapping(uint256 => PendingLock) private pending;

    event Locked(address indexed owner, uint256 indexed tokenId, uint64 unlockTime);
    event Unlocked(address indexed owner, uint256 indexed tokenId);

    constructor() {
        lpNft = IERC721(0xC36442b4a4522E871399CD717aBDD847Ab11FE88);
    }

    /**
     * @notice Locks an LP NFT until specified timestamp.
     * @param tokenId Uniswap V3 position NFT id
     * @param unlockTime Timestamp when unlock is allowed
     */
    function lockPosition(uint256 tokenId, uint64 unlockTime) external {
        require(unlockTime > block.timestamp, "BAD_TIME");
        require(!locks[tokenId].active, "ALREADY_LOCKED");
        require(pending[tokenId].owner == address(0), "PENDING_LOCK");
        require(lpNft.ownerOf(tokenId) == msg.sender, "NOT_NFT_OWNER");

        pending[tokenId] = PendingLock({
            owner: msg.sender,
            unlockTime: unlockTime
        });

        lpNft.safeTransferFrom(msg.sender, address(this), tokenId);
    }

    /**
     * @notice Finalizes lock on NFT transfer.
     */
    function onERC721Received(
        address /*operator*/,
        address from,
        uint256 tokenId,
        bytes calldata /*data*/
    ) external override returns (bytes4) {
        require(msg.sender == address(lpNft), "WRONG_NFT_CONTRACT");

        PendingLock memory p = pending[tokenId];
        require(p.owner != address(0), "NO_PENDING_LOCK");
        require(p.owner == from, "OWNER_MISMATCH");

        locks[tokenId] = LockInfo({
            owner: p.owner,
            unlockTime: p.unlockTime,
            active: true
        });

        delete pending[tokenId];
        emit Locked(p.owner, tokenId, p.unlockTime);

        return IERC721Receiver.onERC721Received.selector;
    }

    /**
     * @notice Unlocks NFT back to the original owner after unlockTime.
     */
    function unlockPosition(uint256 tokenId) external {
        LockInfo memory info = locks[tokenId];
        require(info.active, "NOT_LOCKED");
        require(block.timestamp >= info.unlockTime, "TOO_EARLY");
        require(msg.sender == info.owner, "NOT_OWNER");

        delete locks[tokenId];
        lpNft.safeTransferFrom(address(this), info.owner, tokenId);
        emit Unlocked(info.owner, tokenId);
    }

    /// @notice Returns unlock timestamp
    function lockedUntil(uint256 tokenId) external view returns (uint64) {
        return locks[tokenId].unlockTime;
    }

    /// @notice Extended lock info (optional helper)
    function getLockInfo(uint256 tokenId) external view returns (address owner_, uint64 unlockTime_, bool active_) {
        LockInfo memory info = locks[tokenId];
        return (info.owner, info.unlockTime, info.active);
    }
}
