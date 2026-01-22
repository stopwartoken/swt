# STOPWARTOKEN (SWT)
## Public Self-Audit & Security Disclosure (v1)

> **Network:** Polygon (chain id 137)  
> **Contract model:** Non-upgradeable (no proxy)  
> **Audit type:** Public self-audit (this is **not** a third‑party audit)

---

## 1. Purpose of This Document

This document publishes a **transparent, reproducible self-audit** of the deployed STOPWARTOKEN (SWT) smart contract.

The goal is to clearly state:
- what was reviewed,
- which security properties are enforced by code,
- which trust surfaces exist by design,
- and which risks are explicitly accepted.

No claim is made that this review replaces or equals an independent third‑party audit.

---

## 2. Scope

### In scope
- ERC‑20 token logic (balances, allowances, transfers)
- Charity fee mechanism and exclusions
- On‑chain wallet locks and spend limits
- Permissionless charity and donation triggers
- Governance roles and privileged functions

### Out of scope
- Frontend, website, API, and Cloudflare Workers
- External protocols (Uniswap v3, QuickSwap Algebra, routers, quoter)
- Off‑chain key management and operational security

### Related but out of scope
Liquidity is secured using **standalone ERC‑721 LP locker contracts** (Uniswap v3 and QuickSwap). These contracts:
- are independent from the SWT token,
- are not callable by the token contract,
- do not affect transfer, fee, or charity logic.

They are documented separately in the repository for transparency and are therefore **out of scope** for this self‑audit.

---

## 3. Deployment & Immutability

- The contract uses **no proxy pattern** and has **no upgrade mechanism**.
- All core logic and privileged addresses are fixed at deployment.
- Contract behavior is permanent after deployment.

---

## 4. Roles & Trust Model

### Founder vs token‑holding wallets
- **Founder** is the contract owner (`owner`) and holds operational permissions (`onlyOwner`).
- **ownerWallet** is a separate token‑holding wallet and is **time‑locked on‑chain**.

### Privileged roles

**Contract owner (Founder)** can:
- update bounty amount and charity threshold,
- enable or disable donation triggers,
- manage the donation token whitelist,
- adjust swap slippage (bounded),
- execute `manualSwap` (see Accepted Risks).

**charityAdmin** can:
- reduce the charity fee (monotonic decrease only),
- add fee‑exempt addresses,
- transfer accumulated USDT from the contract.

> **Governance roadmap:** the `charityAdmin` role is intended to become a multisig once humanitarian partnership governance is established.

---

## 5. Key Security Invariants

The following properties are enforced by contract logic:

1. **Fixed total supply:** exactly 1,000,000 SWT minted at deployment.
2. **No minting or burning** after deployment.
3. **No upgradeability:** contract logic cannot be changed.
4. **On‑chain time locks** for `ownerWallet` and `reserveWallet`.
5. **Enforced spending limits** for dev, airdrop, and marketing wallets.
6. **Marketing wallet cannot transfer to contracts.**
7. **Charity fee can only be reduced**, never increased.
8. **Permissionless charity and donation triggers** when conditions are met.
9. **USDT transfers from the contract** occur only via the `charityAdmin` role.

---

## 6. Threat Model

### Considered adversaries
- MEV and arbitrage bots
- Malicious token holders
- Compromised privileged keys
- Operational misconfiguration

### Documented early‑market event
During the earliest trading phase, a small trade moved price out of the active LP range. Corrective liquidity actions were taken to restore normal market behavior. This event does not affect contract integrity and is documented for transparency.

---

## 7. Findings & Accepted Risks

The contract has been live for approximately two months and is non‑upgradeable. The following design risks are documented and accepted.

### 7.1 Swap slippage fallback

In rare execution paths, swap logic may fall back to accepting any output amount.

**Rationale:**
- Swap routes are cached and reused once discovered.
- Non‑SWT token swaps occur only when tokens are sent directly to the contract address.
- Donation swaps are gated by whitelist and enable flags.

**Mitigation:**
- Donation triggers are disabled by default.
- Only high‑liquidity tokens are whitelisted.
- All swaps are publicly observable on‑chain.

---

### 7.2 Charity transfer flexibility

The `charityAdmin` role can transfer accumulated USDT to any address.

**Rationale:**
- Required for operational flexibility in humanitarian transfers.

**Mitigation:**
- Public disclosure of all transfers with on‑chain references.
- Publicly stated priority list of intended humanitarian partners (e.g., UNICEF and similar organizations), subject to verification and approval.
- Planned transition to multisig governance.

---

### 7.3 manualSwap trust surface

The contract owner can manually swap tokens held by the contract.

**Rationale:**
- Intended as an operational recovery and maintenance tool.

**Mitigation:**
- Public commitment that SWT conversions are intended to occur via permissionless triggers.
- All manual swaps emit on‑chain events and are independently verifiable.

---

## 8. Transparency Commitments

- Governance actions and charity transfers will be published with on‑chain evidence.
- Fee reductions and configuration changes remain publicly observable.
- This document may be updated to reflect governance evolution, but not to alter historical claims.

---

## 9. Disclaimer

This document is a public self‑audit intended to disclose assumptions, design decisions, and known risks. It provides **no warranty** and does not guarantee absence of vulnerabilities.

Security is a continuous process, not a label.

