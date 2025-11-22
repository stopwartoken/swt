// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title QuickSwap LP NFT Locker
 * @notice A trustless time-locker for QuickSwap Algebra LP NFTs.
 *         - The original NFT owner calls `lockPosition(tokenId, unlockTime)`.
 *         - Contract takes the NFT via safeTransferFrom and records lock details.
 *         - Only the same address can unlock after lock expiration.
 *         - No owner, no admin privileges, no emergency withdrawal.
 *         - Supports multiple NFTs (one lock per tokenId).
 *
 * @dev lpNft address is set to QuickSwap Algebra NonfungiblePositionManager.
 *      NFT must be transferred via `lockPosition`. Direct transfers are ignored.
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

contract QuickSwapLpNftLocker is IERC721Receiver {
    /// @notice Address of the QuickSwap LP NFT contract
    IERC721 public immutable lpNft;

    /// @notice Final lock details
    struct LockInfo {
        address owner;      // Original NFT owner who locked the position
        uint64 unlockTime;  // Timestamp when unlocking becomes available
        bool active;        // True if currently locked
    }

    /// @notice Pending lock data before transfer is finalized
    struct PendingLock {
        address owner;      // Caller of lockPosition()
        uint64 unlockTime;  // Desired unlock timestamp
    }

    /// @notice tokenId => lock details
    mapping(uint256 => LockInfo) public locks;
    /// @notice tokenId => pending pre-receive data
    mapping(uint256 => PendingLock) private pending;

    event Locked(address indexed owner, uint256 indexed tokenId, uint64 unlockTime);
    event Unlocked(address indexed owner, uint256 indexed tokenId);

    constructor() {
        lpNft = IERC721(0x8eF88E4c7CfbbaC1C163f7eddd4B578792201de6);
    }

    /**
     * @notice Initiates NFT lock.
     *         The NFT will be transferred to this contract via safeTransferFrom.
     * @param tokenId LP NFT identifier
     * @param unlockTime Unix timestamp when NFT can be unlocked
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
     * @notice Finalizes lock after NFT transfer.
     *         Only accepts transfers triggered by lockPosition().
     */
    function onERC721Received(
        address,
        address from,
        uint256 tokenId,
        bytes calldata
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
     * @notice Unlocks NFT after the unlock time has passed.
     * @param tokenId NFT identifier
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

    /// @notice View function to get lock expiration timestamp
    function lockedUntil(uint256 tokenId) external view returns (uint64) {
        return locks[tokenId].unlockTime;
    }
}
