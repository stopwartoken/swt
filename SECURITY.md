# Security & Responsible Disclosure

This document describes how security-related information is handled by the STOPWARTOKEN (SWT) project.

---

## Scope

- This policy applies to the **STOPWARTOKEN smart contracts** and related on-chain components published in this repository.
- It does **not** cover third-party protocols (DEXes, bridges, wallets) or off-chain infrastructure.

---

## Public Security Documentation

SWT follows a transparency-first approach and publishes security documentation openly:

- `AUDIT-SELF.md` — public self-audit of the SWT token contract
- `LP-LOCKERS-SECURITY.md` — security note for LP NFT locker contracts

These documents describe enforced invariants, accepted risks, and governance assumptions.

---

## Responsible Disclosure

Please do **not** open GitHub issues for security or support.

If you identify a potential issue:
- Verify it against the published source code and documentation
- Disclose it responsibly via the official project channels

No private disclosure contacts are provided.

---

## Transparency Principle

SWT relies on **on-chain verifiability** as the primary security mechanism.

All critical actions:
- fee changes,
- charity transfers,
- liquidity locks,
- governance operations

are observable directly on-chain and may be independently reviewed by third parties.

---

## Disclaimer

This project provides no warranty of security. Use and analysis of the contracts are performed at the discretion and risk of third parties.

Security is treated as an ongoing process, not a static guarantee.

