# LP NFT Lockers — Security Note (Self-Review)

> **Scope:** Uniswap v3 & QuickSwap LP NFT Lockers  
> **Audit type:** Public self-review (this is **not** a third-party audit)

---

## 1. Purpose

This document provides a concise **security self-review** of the LP NFT locker contracts used by the STOPWARTOKEN (SWT) project.

The goal is to:
- explain what the locker contracts do,
- document their security-relevant properties,
- clarify ownership and trust assumptions,
- explicitly define what is **in scope** and **out of scope**.

This document complements, but does not extend, the main token self-audit (`AUDIT-SELF.md`).

---

## 2. Contracts Covered

The following standalone contracts are reviewed:

| Contract | Purpose |
|--------|--------|
| `UniswapV3LpNftLocker.sol` | Time-locks Uniswap v3 LP ERC-721 NFTs |
| `QuickSwapLpNftLocker.sol` | Time-locks QuickSwap (Algebra) LP ERC-721 NFTs |

Both contracts are published in the repository under `contracts/`.

---

## 3. Scope

### In scope
- NFT custody logic
- Time-lock enforcement (`unlockTime`)
- Ownership and access control
- Withdrawal conditions

### Out of scope
- Security of Uniswap v3 or QuickSwap protocols
- ERC-721 implementations used by DEXes
- LP position value, impermanent loss, or price behavior
- Off-chain key security

---

## 4. Design Overview

The locker contracts follow a minimal design:

- Each LP position is represented by an ERC-721 NFT
- NFTs are transferred into the locker contract
- Each NFT is associated with a fixed `unlockTime`
- Withdrawal is only possible **after** the unlock timestamp
- No interaction exists between locker contracts and the SWT token contract

The lockers do not mint, burn, or modify LP positions. They only act as custodial time locks.

---

## 5. Ownership & Trust Model

- **Owner:** `liquidityWallet` (project-designated liquidity wallet)
- The owner can:
  - lock LP NFTs by transferring them into the locker
  - withdraw LP NFTs **only after** the unlock time

There are no additional privileged roles.

---

## 6. Security Invariants

The following properties are enforced by contract logic:

1. **LP NFTs cannot be withdrawn before `unlockTime`.**
2. **Ownership checks** restrict withdrawal to the contract owner.
3. **Unlock timestamps are immutable per position** once set.
4. **No proxy or upgrade mechanism** exists.
5. **No interaction with SWT token logic** is possible.
6. **No external calls** are performed beyond standard ERC-721 transfers.

---

## 7. Threat Model

### Considered adversaries
- External users attempting early withdrawal
- Malicious callers without ownership
- Accidental misuse by the owner

### Non-considered threats
- Compromise of the owner private key
- Failures or exploits in Uniswap v3 / QuickSwap

---

## 8. Findings & Accepted Risks

### Centralized ownership

The locker contracts are owned by a single wallet (`liquidityWallet`).

**Risk:** Compromise of this key could allow withdrawal of LP NFTs **after** unlock time.

**Rationale:**
- Ownership is required to maintain operational control over liquidity.
- Unlock timestamps prevent early withdrawal regardless of owner intent.

**Mitigation:**
- Public on-chain verification of lock status and unlock timestamps
- Optional future migration to multisig ownership if governance evolves

---

## 9. Transparency Commitments

- LP lock transactions and unlock times are independently verifiable on-chain.
- For convenience, current LP lock status and unlock timestamps are also exposed via a **read-only transparency endpoint** described in `docs/STATS_API.md`. This endpoint does not replace on-chain verification.
- Locker contract sources are published in this repository.
- This document may be updated for clarity, but not to alter historical claims.

---

## 10. Disclaimer

This document is a public self-review of LP locker contracts. It does not constitute a third-party audit and provides no warranty of security.

The lockers are simple custodial time locks and are intended to reduce, not eliminate, trust assumptions.

