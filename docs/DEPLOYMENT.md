# Deployment

This document describes the original deployment of the STOPWARTOKEN (SWT) contract.

All parameters below can be independently verified on-chain.

---

## Network

- **Chain:** Polygon (POL)
- **Chain ID:** 137

---

## Token Contract

- **Address:**  
  `0x49786b20c0E076CDF82F6b07d55312dF9e265db0`

- **Standard:** ERC-20  
- **Supply model:** Fixed (no mint)  
- **Upgradeability:** None (no proxy)

---

## Deployment Transaction

- **Transaction hash:**  
  https://polygonscan.com/tx/0x919c507a7983f3f03d41b49ebde0f9bee3dc4bf7ee186f7684496d1e58abe4d8

- **Deployment block:**  
  `78832159`

- **Timestamp:**  
  Nov-10-2025 10:06:42 UTC

---

## Compiler

- **Solidity version:** 0.8.24  
- **Optimization:** enabled

---

## Source Code

- Primary source file:  
  [`contracts/STOPWARTOKEN.sol`](contracts/STOPWARTOKEN.sol)

- Contract is published as a **flattened single file**:
  - no imports  
  - no proxy pattern  
  - no upgrade hooks  

This ensures the deployed bytecode corresponds directly to a single readable source.

---

## Verification

To independently verify deployment:

1. Open the deployment transaction on Polygonscan  
2. Confirm the contract address  
3. Check the bytecode and compiler version  
4. Compare with the source file in this repository  
5. Review contract functions and parameters  

No off-chain claims are required for verification.

---

## Deterministic Properties

At deployment, the following properties were fixed:

- Total supply: **1,000,000 SWT**
- Humanitarian fee: **0.1% per transfer**
- No mint function
- No upgrade mechanism
- No owner-controlled supply changes

Some administrative parameters exist but are **strictly limited**:

- Fee can only be reduced (not increased)
- Charity distribution is executed via explicit on-chain calls

Full details:  
- [`AUDIT-SELF.md`](AUDIT-SELF.md)  
- [`SECURITY.md`](SECURITY.md)

---

## Relationship to Other Components

The token contract is **independent** from:

- LP locker contracts  
- DEX pools (Uniswap / QuickSwap)  
- Website and API  

These components interact with the token but cannot modify its core logic.

---

## Notes

- This repository reflects the deployed state of the system  
- The contract is immutable after deployment  
- All ongoing activity happens through public on-chain interactions  

---

## Summary

Deployment defines the system.

Everything else — liquidity, UI, API — operates around it.

Verify the deployment first.
