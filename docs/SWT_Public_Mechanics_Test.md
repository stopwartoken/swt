# SWT Public Mechanics Test — May 2026

Status: planned / live  
Initial publication date: 2026-05-11  
Planned test window: 2026-05-12 to 2026-05-15  
Final report target: 2026-05-18  
Network: Polygon

---

## Purpose

The purpose of this public mechanics test is to document the full SWT path under real on-chain conditions:

POL input → routed SWT purchase → SWT fee accumulation → 50 SWT trigger threshold → permissionless `triggerCharity()` → USDT held on the SWT contract → first charity transfer path.

The test is designed to make the mechanism observable through public transactions.

---

## Non-purpose

This is not a trading signal.

This is not an invitation to buy.

This is not a price campaign.

This is not a promise of liquidity, price stability, price safety, or returns.

This is not an attempt to represent team-controlled activity as external user activity.

This is not a claim that a single test proves safety.

---

## Public test wallet

The SWT Public Test Wallet is publicly disclosed before POL → SWT test swap activity begins.

- SWT Public Test Wallet: [`0x3020929156916c1f06120Efb033c8C61A7E1c208`](https://polygonscan.com/address/0x3020929156916c1f06120Efb033c8C61A7E1c208)
- SWT creator/admin wallet: [`0xBc122bE1b62f0B8718C9dC9918ce2cd7C160BA07`](https://polygonscan.com/address/0xBc122bE1b62f0B8718C9dC9918ce2cd7C160BA07)
- Funding transaction: [`0x82d222a13addfee7b157fe66c76307c6c5c989f9bc808ccdde8f0164ffa0b91d`](https://polygonscan.com/tx/0x82d222a13addfee7b157fe66c76307c6c5c989f9bc808ccdde8f0164ffa0b91d)
- Funding source: SWT creator/admin wallet

The SWT Public Test Wallet is team-controlled and used only for this mechanics test.

It is not an external participant.

It is not an independent buyer.

Any activity from this wallet should be interpreted only as disclosed test activity.

---

## Input asset and routing

The test will use POL as the input asset.

This reflects a normal Polygon user flow: a user can fund a wallet with POL, connect through MetaMask or another wallet, and let the DEX/router find an available route to SWT.

SWT liquidity is currently denominated through USDT/SWT pools. The USDT price is used as a readable accounting reference, while the actual input asset for the public test is POL.

The exact execution route will be documented from the transaction data.

---

## Core contracts and references

- SWT token contract: [`0x49786b20c0E076CDF82F6b07d55312dF9e265db0`](https://polygonscan.com/address/0x49786b20c0E076CDF82F6b07d55312dF9e265db0)
- Network: Polygon
- Primary price source: Uniswap V3
- Primary pool: [`0x671922175c51ECbeAB90039647348B0bD3Fa5d86`](https://polygonscan.com/address/0x671922175c51ECbeAB90039647348B0bD3Fa5d86)
- Secondary pool: [`0x73564cC139D2e8e9eA0eCe54f54a3d61AbFfC046`](https://polygonscan.com/address/0x73564cC139D2e8e9eA0eCe54f54a3d61AbFfC046)
- Public stats API: [`https://stopwartoken.org/api/stats`](https://stopwartoken.org/api/stats)
- Website: [`https://stopwartoken.org`](https://stopwartoken.org)

---

## Live status

Last updated: 2026-05-12 09:30 UTC

| Field | Status |
|---|---|
| Test phase | Test started — no POL → SWT swap activity yet |
| Network | Polygon |
| Input asset | POL |
| Readable price reference | USDT/SWT pools |
| Test wallet | [`0x3020929156916c1f06120Efb033c8C61A7E1c208`](https://polygonscan.com/address/0x3020929156916c1f06120Efb033c8C61A7E1c208) |
| Test wallet disclosure status | Disclosed before POL → SWT test swap activity |
| Funding source | SWT creator/admin wallet |
| Creator/admin wallet | [`0xBc122bE1b62f0B8718C9dC9918ce2cd7C160BA07`](https://polygonscan.com/address/0xBc122bE1b62f0B8718C9dC9918ce2cd7C160BA07) |
| Funding tx | [0x82d222a13addfee7b157fe66c76307c6c5c989f9bc808ccdde8f0164ffa0b91d](https://polygonscan.com/tx/0x82d222a13addfee7b157fe66c76307c6c5c989f9bc808ccdde8f0164ffa0b91d) |
| Public test wallet funding amount | 5,000 POL |
| First POL → SWT swap tx | TBA |
| Current accumulated SWT fee | 16.88 / 50 SWT |
| Trigger threshold | 50 SWT |
| Threshold reached | No |
| `triggerCharity()` status | Not executed |
| Trigger tx | TBA |
| USDT held on SWT contract after trigger | TBA |
| Protocol-generated USDT | TBA |
| Founder top-up | Planned / reported separately |
| First charity transfer test | Planned |
| Recipient | TBA |
| Final report status | Pending |

---

## Method

The test will use a disclosed team-controlled wallet to create observable on-chain activity.

The expected path is:

1. Publish the test framework.
2. Disclose the SWT Public Test Wallet.
3. Fund the SWT Public Test Wallet from the SWT creator/admin wallet.
4. Execute controlled POL → SWT swap activity through normal Polygon DEX routing.
5. Observe SWT fee accumulation on the SWT contract.
6. Track progress toward the 50 SWT trigger threshold.
7. Once the threshold is reached, observe the permissionless trigger window.
8. Document whether `triggerCharity()` is called by an external wallet or by the team after the observation window.
9. Document the resulting USDT balance held on the SWT contract.
10. Document any later movement of the test wallet position.
11. Document the first charity transfer path, if completed during the reporting window.

---

## External activity policy

External wallets may interact with SWT during the test window.

If this happens, their transactions may be listed only when relevant to the fee accumulation or trigger path.

No intent, affiliation, endorsement, or participation is implied.

SWT does not infer intent from public on-chain activity.

External wallets will not be described as participants unless they explicitly identify themselves as such.

---

## Trigger policy

Once the 50 SWT trigger threshold is reached, `triggerCharity()` becomes permissionless under the deployed contract rules.

SWT will observe a reasonable permissionless trigger window before taking further action.

If an external wallet calls `triggerCharity()`, the transaction will be documented.

If no external trigger occurs during the observation window, the SWT team may call `triggerCharity()` from a disclosed wallet to complete the mechanics test.

Any bounty behavior is defined by the deployed smart contract.

This report does not promise or guarantee any reward.

---

## First charity transfer test

After the mechanics test, SWT plans a first charity transfer test.

If a founder-funded top-up is used, it will be reported separately from protocol-generated USDT.

The report will separate:

- protocol-generated USDT;
- founder-funded top-up;
- total transferred amount;
- recipient address or donation route;
- transfer transaction;
- public confirmation, if available.

No amount will be presented as larger than it is.

The purpose of the first transfer test is to document the path from on-chain fee flow to an actual humanitarian transfer, without overstating early protocol-generated impact.

---

## Test wallet position policy

The SWT Public Test Wallet may later hold, partially unwind, or unwind its test position.

Any such movement will be documented.

The purpose of the test is not accumulation, price movement, or market signaling.

The purpose is to document the fee path under real DEX conditions.

---

## Public event and transaction log

| Date | Actor | Action | Reference | Result |
|---|---|---|---|---|
| 2026-05-11 | SWT team | Rules published | This file / GitHub commit | Framework disclosed |
| 2026-05-11 | Creator/admin wallet | Funded test wallet | [funding tx](https://polygonscan.com/tx/0x82d222a13addfee7b157fe66c76307c6c5c989f9bc808ccdde8f0164ffa0b91d) | 5,000 POL funded |
| 2026-05-12 | SWT team | Test start announced | This file / Discord / X | Public mechanics test opened; no POL → SWT swap activity yet |
| TBA | Test wallet | First POL → SWT swap | TBA | TBA |
| TBA | Test wallet | Additional POL → SWT swaps | TBA | TBA |
| TBA | SWT contract | Threshold reached | TBA | 50 SWT fee threshold |
| TBA | TBA | `triggerCharity()` | TBA | TBA |
| TBA | SWT contract | USDT received after trigger | TBA | TBA |
| TBA | Test wallet | Position movement, if any | TBA | TBA |
| TBA | Creator/admin wallet | Founder top-up, if used | TBA | Reported separately |
| TBA | SWT contract / CharityAdmin | First charity transfer test | TBA | TBA |
| TBA | Recipient / donation platform | Receipt or public confirmation, if available | TBA | TBA |

---

## Live event log

### 2026-05-11 — Rules published

The public mechanics test framework was published.

No test swap activity has started yet.

### 2026-05-12 — Test start

The public mechanics test has started.

At this stage, no POL → SWT test swap activity has been executed from the disclosed SWT Public Test Wallet.

The test wallet, funding source, and funding transaction are already disclosed. The next update will document the first controlled POL → SWT swap activity once executed.

### 2026-05-13 — Test update

TBA

### 2026-05-14 — Threshold / observation update

TBA

### 2026-05-15 — Trigger / completion update

TBA

### 2026-05-16 to 2026-05-17 — Buffer and verification

TBA

### 2026-05-18 — Final report

TBA

---

## Final summary

TBA

Expected final summary fields:

- Test wallet disclosed before POL → SWT test swap activity: Yes
- Test wallet: `0x3020929156916c1f06120Efb033c8C61A7E1c208`
- Funding source disclosed: Yes — SWT creator/admin wallet `0xBc122bE1b62f0B8718C9dC9918ce2cd7C160BA07`
- Funding transaction documented: `0x82d222a13addfee7b157fe66c76307c6c5c989f9bc808ccdde8f0164ffa0b91d`
- Public test wallet funding amount: 5,000 POL
- POL → SWT execution path documented: TBA
- Swap activity documented: TBA
- SWT fee accumulation observed: TBA
- 50 SWT threshold reached: TBA
- `triggerCharity()` executed: TBA
- Trigger caller: TBA
- Trigger tx: TBA
- USDT held on SWT contract after trigger: TBA
- Protocol-generated USDT amount: TBA
- Founder-funded top-up amount, if any: TBA
- First charity transfer completed: TBA
- Recipient / donation route: TBA
- Transfer tx: TBA
- Receipt / public confirmation: TBA
- Test wallet position movement documented: TBA
- Final state independently verifiable: TBA

---

## Final note

This test does not ask anyone to believe the mechanism.

It is designed so the mechanism can be followed through public transactions.

Verification over claims.
