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

Last updated: 2026-05-13 13:30 UTC

| Field | Status |
|---|---|
| Test phase | Fourth small-swap series completed; MetaMask POL route repeated |
| Network | Polygon |
| Input assets used | POL / USDT |
| Readable price reference | USDT/SWT pools |
| Test wallet | [`0x3020929156916c1f06120Efb033c8C61A7E1c208`](https://polygonscan.com/address/0x3020929156916c1f06120Efb033c8C61A7E1c208) |
| Test wallet disclosure status | Disclosed before POL → SWT test swap activity |
| Funding source | SWT creator/admin wallet |
| Creator/admin wallet | [`0xBc122bE1b62f0B8718C9dC9918ce2cd7C160BA07`](https://polygonscan.com/address/0xBc122bE1b62f0B8718C9dC9918ce2cd7C160BA07) |
| Funding tx | [0x82d222a13addfee7b157fe66c76307c6c5c989f9bc808ccdde8f0164ffa0b91d](https://polygonscan.com/tx/0x82d222a13addfee7b157fe66c76307c6c5c989f9bc808ccdde8f0164ffa0b91d) |
| Public test wallet funding amount | 5,000 POL |
| First POL → SWT swap tx | [first swap tx](https://polygonscan.com/tx/0xd4700f018cddfca2281d5c3f4ea7e2ce45facf16419e4fb0622a47a20918fd54) |
| Latest SWT swap tx | [swap 12](https://polygonscan.com/tx/0x4ce62292d695f46f84c65cc880209d7ad5bc9d7cd651a6242bec257f0832fe8b) |
| POL → USDT preparation tx | [prep tx](https://polygonscan.com/tx/0xc4bbc51d67f2abe1063345ce628f284101a6be95340664ffb75e01a5163eab9e) |
| Current accumulated SWT fee | 33.10 / 50 SWT |
| Trigger threshold | 50 SWT |
| Threshold reached | No |
| `triggerCharity()` status | Not executed |
| Trigger tx | TBA |
| USDT held on SWT contract after trigger | TBA |
| Protocol-generated USDT | TBA |
| Founder top-up | Planned / reported separately |
| First charity transfer test | Planned |
| Recipient | TBA |
| Latest series measurement | MetaMask POL → SWT repeat: 27.95 → 33.10 fee accumulated (+5.15 SWT) |
| Cross-pool observation | Direct Uniswap-route swaps widened the visible pool spread; later external market activity reduced it |
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
| 2026-05-12 | Test wallet | First POL → SWT swap | [swap 1](https://polygonscan.com/tx/0xd4700f018cddfca2281d5c3f4ea7e2ce45facf16419e4fb0622a47a20918fd54) | First controlled test swap executed |
| 2026-05-12 | Test wallet | Additional POL → SWT swap | [swap 2](https://polygonscan.com/tx/0x427856ae082b7022ce3cef8dd8d49bbe66448ffc9e642e81cb3d18739ceedbd7) | Controlled test swap executed |
| 2026-05-12 | Test wallet | Additional POL → SWT swap | [swap 3](https://polygonscan.com/tx/0xa6b780c5657ea5e49481ba26eef27a6edbd09dae78ebfc94b4bc8818840fc2ec) | Controlled test swap executed |
| 2026-05-12 | Test wallet | Uniswap POL → SWT swap | [swap 4](https://polygonscan.com/tx/0xd2b046cfa8cf48f6903cc44abdfc34bf0d0f084c315f5cd2bfb94120a9378933) | Direct pool-output route comparison; no additional SWT fee accumulation observed |
| 2026-05-12 | Test wallet | Uniswap POL → SWT swap | [swap 5](https://polygonscan.com/tx/0xa6a18989bbeed7010e4905375d06d7cbeb85d69a0fc37ba6fbb146cb9eca2410) | Direct pool-output route comparison; no additional SWT fee accumulation observed |
| 2026-05-12 | Test wallet | Uniswap POL → SWT swap | [swap 6](https://polygonscan.com/tx/0x4afb96d400261e13ad1b8c18949fd2d112c80eeefd24bc4598e20b89e73dcae3) | Second small-swap series completed; direct pool-output route behavior documented |
| 2026-05-12 | External wallet | Cross-pool re-alignment activity | [external tx 1](https://polygonscan.com/tx/0xda13d3c85fa459c6211c229fb9e1519fe3c2a36e4867aca7fbff2eee8c628e5d) | Observed after direct Uniswap-route swaps; not SWT team activity |
| 2026-05-12 | External wallet | Additional cross-pool re-alignment activity | [external tx 2](https://polygonscan.com/tx/0x56972b166cb55a4f37b096c072f2d703cca55a0b5660654c684cc945ee2fc105) | External market activity reduced the visible pool spread |
| 2026-05-13 | Test wallet | POL → USDT preparation swap | [prep tx](https://polygonscan.com/tx/0xc4bbc51d67f2abe1063345ce628f284101a6be95340664ffb75e01a5163eab9e) | Prepared USDT for MetaMask USDT → SWT route comparison; not an SWT fee event |
| 2026-05-13 | Test wallet | MetaMask USDT → SWT route comparison | [swap 7](https://polygonscan.com/tx/0x3466e4be7e892cf442369d20a17b8e7b2735e768ddaea5e0269a1705a1c81614) | Tested USDT input route behavior |
| 2026-05-13 | Test wallet | MetaMask USDT → SWT route comparison | [swap 8](https://polygonscan.com/tx/0xeb2e86dfa1bf8aa271aac73ae940b9da150359933727b700c07966264334cb5c) | Controlled USDT → SWT route comparison swap |
| 2026-05-13 | Test wallet | MetaMask USDT → SWT route comparison | [swap 9](https://polygonscan.com/tx/0xfe4d2b652816f6d720ce96010c62a1cd10d8c3daee63b7ecf5a8d8d3f0889a17) | USDT → SWT route comparison series completed |
| 2026-05-13 | Test wallet | MetaMask POL → SWT route repeat | [swap 10](https://polygonscan.com/tx/0xa10794cd7cb1f79fa4cce3922e88285f30bd0187df802559bb2ac860d0e6ce9e) | Repeated routed POL input after route-comparison results |
| 2026-05-13 | Test wallet | MetaMask POL → SWT route repeat | [swap 11](https://polygonscan.com/tx/0xa1c33a88997fceafd1c864d6e5903d4b358c3004c50f62c75d03172be96bc3df) | Controlled routed POL → SWT test swap |
| 2026-05-13 | Test wallet | MetaMask POL → SWT route repeat | [swap 12](https://polygonscan.com/tx/0x4ce62292d695f46f84c65cc880209d7ad5bc9d7cd651a6242bec257f0832fe8b) | Fourth small-swap series completed |
| TBA | Test wallet | Additional SWT route-comparison swaps, if any | TBA | TBA |
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

Two controlled POL → SWT small-swap series were executed from the disclosed SWT Public Test Wallet.

First small-swap series:

- First swap: [swap 1](https://polygonscan.com/tx/0xd4700f018cddfca2281d5c3f4ea7e2ce45facf16419e4fb0622a47a20918fd54)
- Additional swap: [swap 2](https://polygonscan.com/tx/0x427856ae082b7022ce3cef8dd8d49bbe66448ffc9e642e81cb3d18739ceedbd7)
- Additional swap: [swap 3](https://polygonscan.com/tx/0xa6b780c5657ea5e49481ba26eef27a6edbd09dae78ebfc94b4bc8818840fc2ec)

Second small-swap series:

- Uniswap-route swap: [swap 4](https://polygonscan.com/tx/0xd2b046cfa8cf48f6903cc44abdfc34bf0d0f084c315f5cd2bfb94120a9378933)
- Uniswap-route swap: [swap 5](https://polygonscan.com/tx/0xa6a18989bbeed7010e4905375d06d7cbeb85d69a0fc37ba6fbb146cb9eca2410)
- Uniswap-route swap: [swap 6](https://polygonscan.com/tx/0x4afb96d400261e13ad1b8c18949fd2d112c80eeefd24bc4598e20b89e73dcae3)

Current accumulated SWT fee after this update: 22.59 / 50 SWT.

Series measurements:

First small-swap series — MetaMask routed POL input:

- Accumulated SWT fee before series: 16.88 / 50 SWT
- Accumulated SWT fee after series: 22.59 / 50 SWT
- Observed fee delta: +5.71 SWT

Second small-swap series — Uniswap POL → SWT route:

- Accumulated SWT fee before series: 22.59 / 50 SWT
- Accumulated SWT fee after series: 22.59 / 50 SWT
- Observed fee delta: 0.00 SWT

Route observation:

The first small-swap series used routed POL input through MetaMask. The test wallet received approximately 2,850 SWT, while accumulated SWT fee increased by 5.71 SWT.

This is consistent with more than one taxable SWT transfer occurring inside the routed execution path.

The second small-swap series used Uniswap POL → SWT swaps for comparison. In this route, the SWT output was transferred directly from a fee-excluded liquidity pool to the test wallet.

No additional SWT fee accumulation was observed from the direct pool-output route.

This confirms that SWT fee accumulation is route-dependent and depends on whether SWT transfers pass through non-exempt addresses before final receipt.

Cross-pool pricing observation:

The direct Uniswap-route swaps affected the Uniswap-side price more directly and increased the visible spread between SWT pools.

After that, external market activity reduced the cross-pool spread.

This is documented as observed market-driven pool re-alignment. It is separate from the disclosed SWT Public Test Wallet activity and does not imply affiliation, endorsement, or participation by any external wallet.

- Relevant external txs:

- Cross-pool re-alignment tx 1: [external tx 1](https://polygonscan.com/tx/0xda13d3c85fa459c6211c229fb9e1519fe3c2a36e4867aca7fbff2eee8c628e5d)
- Cross-pool re-alignment tx 2: [external tx 2](https://polygonscan.com/tx/0x56972b166cb55a4f37b096c072f2d703cca55a0b5660654c684cc945ee2fc105)

The trigger threshold has not been reached yet. `triggerCharity()` has not been executed.

### 2026-05-13 — MetaMask USDT route comparison

A MetaMask USDT → SWT route comparison series was executed from the disclosed SWT Public Test Wallet.

Before the SWT swaps, the test wallet converted a small amount of POL to USDT for route-comparison preparation.

This preparation transaction is documented separately and is not counted as SWT fee-generating activity.

Preparation transaction:

- POL → USDT preparation swap: [prep tx](https://polygonscan.com/tx/0xc4bbc51d67f2abe1063345ce628f284101a6be95340664ffb75e01a5163eab9e)

MetaMask USDT → SWT route comparison series:

- Swap 7: [swap 7](https://polygonscan.com/tx/0x3466e4be7e892cf442369d20a17b8e7b2735e768ddaea5e0269a1705a1c81614)
- Swap 8: [swap 8](https://polygonscan.com/tx/0xeb2e86dfa1bf8aa271aac73ae940b9da150359933727b700c07966264334cb5c)
- Swap 9: [swap 9](https://polygonscan.com/tx/0xfe4d2b652816f6d720ce96010c62a1cd10d8c3daee63b7ecf5a8d8d3f0889a17)

Series measurements:

Third small-swap series — MetaMask USDT input:

- Accumulated SWT fee before series: 22.59 / 50 SWT
- Accumulated SWT fee after series: 27.95 / 50 SWT
- Observed fee delta: DELTA 5.36 SWT

The purpose of this series was to test whether fee accumulation depends on the input asset, the interface, or the actual SWT transfer path visible in transaction logs.

Route observation:

The MetaMask USDT → SWT route produced a fee delta close to two taxable SWT transfers.

This suggests that the resulting SWT output path again included more than one non-exempt SWT transfer before final receipt.

Fourth small-swap series — MetaMask POL input repeat:

A fourth controlled small-swap series was executed from the disclosed SWT Public Test Wallet.

This series repeated the MetaMask POL → SWT route after the earlier route-comparison observations.

Transactions:

- Swap 10: [swap 10](https://polygonscan.com/tx/0xa10794cd7cb1f79fa4cce3922e88285f30bd0187df802559bb2ac860d0e6ce9e)
- Swap 11: [swap 11](https://polygonscan.com/tx/0xa1c33a88997fceafd1c864d6e5903d4b358c3004c50f62c75d03172be96bc3df)
- Swap 12: [swap 12](https://polygonscan.com/tx/0x4ce62292d695f46f84c65cc880209d7ad5bc9d7cd651a6242bec257f0832fe8b)

Series measurements:

- Accumulated SWT fee before series: 27.95 / 50 SWT
- Accumulated SWT fee after series: 33.10 / 50 SWT
- Observed fee delta: +5.15 SWT

Route observation:

The fourth series produced additional SWT fee accumulation consistent with the earlier MetaMask-routed behavior.

This further supports the current route observation: SWT fee accumulation depends on the actual SWT transfer path and whether transfers pass through non-exempt intermediate addresses before final receipt.

The trigger threshold has not been reached yet. `triggerCharity()` has not been executed.

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
