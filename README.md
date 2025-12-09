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

## LP Lockers

Independent ERC-721 locker contracts are used to secure liquidity positions:

| Contract                     | Purpose                    | Address                                    |
|------------------------------|----------------------------|--------------------------------------------|
| `UniswapV3LpNftLocker.sol`   | Locks Uniswap v3 LP NFTs   | `0xAB1cC7100ECD873207f66DD9C6711ffE3B3b912A` |
| `QuickSwapLpNftLocker.sol`   | Locks QuickSwap v3 LP NFTs | `0xB968456948D1bc72d83F9b52389Ac614B4016633` |

- Each position is locked via `lockPosition(tokenId, unlockTime)`
- NFTs can only be withdrawn **after the unlock timestamp**
- Lockers are **standalone** and do **not impact SWT token logic**
- Used **exclusively to secure long-term liquidity**

Sources:  
[`contracts/UniswapV3LpNftLocker.sol`](contracts/UniswapV3LpNftLocker.sol)  
[`contracts/QuickSwapLpNftLocker.sol`](contracts/QuickSwapLpNftLocker.sol)

---

## Repository layout

- `contracts/STOPWARTOKEN.sol` – main ERC-20 token contract (flattened, no imports)  
- `contracts/UniswapV3LpNftLocker.sol` – Uniswap v3 LP NFT locker  
- `contracts/QuickSwapLpNftLocker.sol` – QuickSwap Algebra LP NFT locker  
- `docs/STOPWARTOKEN_Whitepaper.pdf` – whitepaper (public reference copy)  
- `docs/STOPWARTOKEN_Whitepaper_HASH.txt` – SHA-256 hash of the PDF  
- `docs/STATS_API.md` – description of the public transparency JSON endpoint  
- `LICENSE`, `NOTICE` – licensing and notice information for this repository  

---

## Transparency API (`/api/stats`)

A small read-only JSON endpoint is exposed for third-party tooling and independent verification:

- **URL:** `https://stopwartoken.org/api/stats`  
- **Method:** `GET`  
- **Content-Type:** `application/json`  
- **Refresh interval:** approximately every 15 minutes  
- **Data source:** on-chain state on Polygon (SWT token, LP positions, lockers)

The endpoint aggregates:

- Basic token metadata (`meta`)
- Indicative SWT/USDT market price from the main Uniswap v3 pool (`market`)
- Current and lifetime humanitarian fee statistics (`charity`)
- Liquidity lock status for Uniswap v3 and QuickSwap pools (`liquidity`)

A field-by-field description and example payload are available in  
[`docs/STATS_API.md`](docs/STATS_API.md)

The endpoint is **read-only**, does not require authentication and does not implement any tracking logic.  
It is provided purely for transparency and research purposes.

---

## Whitepaper

- **PDF:** [`docs/STOPWARTOKEN_Whitepaper.pdf`](docs/STOPWARTOKEN_Whitepaper.pdf)  
- **SHA-256:** see [`docs/STOPWARTOKEN_Whitepaper_HASH.txt`](docs/STOPWARTOKEN_Whitepaper_HASH.txt)

---

## Governance (short)

- Humanitarian multisig **2/2** (Founder + humanitarian representative)  
- Fee **0.1%**, may only be **reduced** (to 0.05%), never increased  
- No mint, no proxy, **fixed supply: 1,000,000 SWT**

---

## Official Links

- Website: https://stopwartoken.org  
- X: https://x.com/StopwarTokenOrg  
- Discord: https://discord.gg/PktJPn3Unb  

---

### Project Notes

STOPWARTOKEN is deployed without presale, marketing allocations, or external funding.  
The project operates without centralized roles or incentives.

All mechanisms are fully executed on-chain.  
Interaction with the token and related contracts requires no trust in any entity, and all actions can be independently verified.

> This repository is published solely for transparency.  
> It does not solicit investment, engagement, or support.  
> Any further use or analysis is at the discretion of third parties.

---

_No support via GitHub issues. Official updates are published on the channels above._
