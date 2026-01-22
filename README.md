# STOPWARTOKEN (SWT) — Blockchain for Peace

Transparent humanitarian token on Polygon (POL).
**0.1% of every transaction** is routed to a dedicated humanitarian multisig.
All flows are verifiable on-chain.

---

## Token Contract

- **Network:** Polygon (POL, chain id 137)
- **Address:** `0x49786b20c0E076CDF82F6b07d55312dF9e265db0`
- **Standard:** ERC-20, flattened single file (no imports, no proxy)
- **Compiler:** Solidity 0.8.24

Source: [`contracts/STOPWARTOKEN.sol`](contracts/STOPWARTOKEN.sol)

---

## Security Documentation

This repository publishes security documentation as **separate, scope-limited files**:

- **Public self-audit (token logic):** [`AUDIT-SELF.md`](AUDIT-SELF.md)
- **LP locker security note:** [`LP-LOCKERS-SECURITY.md`](LP-LOCKERS-SECURITY.md)
- **Responsible disclosure & security policy:** [`SECURITY.md`](SECURITY.md)

Each document is self-contained and addresses a specific contract scope.

---

## LP Lockers

Independent ERC-721 locker contracts are used to secure liquidity positions:

| Contract | Purpose | Address |
|---------|---------|---------|
| `UniswapV3LpNftLocker.sol` | Locks Uniswap v3 LP NFTs | `0xAB1cC7100ECD873207f66DD9C6711ffE3B3b912A` |
| `QuickSwapLpNftLocker.sol` | Locks QuickSwap v3 LP NFTs | `0xB968456948D1bc72d83F9b52389Ac614B4016633` |

- Each position is locked via `lockPosition(tokenId, unlockTime)`
- NFTs can only be withdrawn **after the unlock timestamp**
- Lockers are **standalone** and do **not interact** with SWT token logic

Sources:
- [`contracts/UniswapV3LpNftLocker.sol`](contracts/UniswapV3LpNftLocker.sol)
- [`contracts/QuickSwapLpNftLocker.sol`](contracts/QuickSwapLpNftLocker.sol)

---

## Transparency API (`/api/stats`)

A small read-only JSON endpoint is exposed for independent verification:

- **URL:** `https://stopwartoken.org/api/stats`
- **Method:** `GET`
- **Refresh interval:** ~10 minutes
- **Data source:** on-chain state on Polygon

The endpoint aggregates:
- token metadata (`meta`)
- indicative SWT/USDT market price (`market`)
- current and lifetime humanitarian fee statistics (`charity`)
- LP lock status and unlock timestamps (`liquidity`)

Format and verification details are described in [`docs/STATS_API.md`](docs/STATS_API.md).

> The API is read-only and provided purely for convenience. On-chain data remains the source of truth.

---

## Governance (short)

- Humanitarian multisig **2/2** (Founder + humanitarian representative)
- Fee **0.1%**, may only be **reduced** (to 0.05%), never increased
- No mint, no proxy, **fixed supply: 1,000,000 SWT**

---

## Whitepaper

A conceptual whitepaper describing the motivation, principles, and long-term vision of STOPWARTOKEN is available in this repository.

- Document: [`docs/STOPWARTOKEN_Whitepaper.pdf`](docs/STOPWARTOKEN_Whitepaper.pdf)
- Integrity hash: [`docs/STOPWARTOKEN_Whitepaper_HASH.txt`](docs/STOPWARTOKEN_Whitepaper_HASH.txt)

The whitepaper does not define protocol behavior or security guarantees.  
On-chain code and public security documents remain the sole source of truth.

---

## Inspiration

The idea behind STOPWARTOKEN was inspired by real-world acts of personal responsibility and humanitarian commitment.

One such example is Nobel Peace Prize laureate **Dmitry Muratov**, who sold his Nobel medal for over $100 million and donated the entire amount to humanitarian aid through UNICEF.

SWT explores whether similar principles of **transparent, verifiable aid** can be implemented natively on-chain.

---

## Official Links

- Website: https://stopwartoken.org
- X: https://x.com/StopwarTokenOrg
- Discord: https://discord.gg/PktJPn3Unb

---

### Project Notes

STOPWARTOKEN is deployed without presale, marketing allocations, or external funding.

All core mechanisms are executed on-chain and can be independently verified.

> This repository is published for transparency and research purposes only.
> It does not solicit investment or participation.

---

_No support via GitHub issues. Official updates are published on the channels above._
