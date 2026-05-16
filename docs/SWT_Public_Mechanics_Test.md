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

Last updated: 2026-05-16 18:00 UTC

| Field | Status |
|---|---|
| Test phase | Initial mechanics test completed; post-test position unwind / route observation active |
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
| Latest SWT swap tx | [swap 24](https://polygonscan.com/tx/0x5ba54538d6789e2214da46aec74b98a774472730d78407402775dab35d000d9a) |
| Post-trigger accumulated SWT fee | 8.37 / 50 SWT |
| Trigger threshold | 50 SWT |
| Next trigger threshold reached | No |
| `triggerCharity()` status | Executed on 2026-05-15 |
| Public trigger window | Closed for this test cycle after team trigger execution |
| Threshold tx | [THRESHOLD_SWAP](https://polygonscan.com/tx/0xbf10be180605e1d68fbfd4ab4c4cd59b103ece809003270516edcfd9029c0aea) |
| Trigger caller | Disclosed SWT Public Test Wallet |
| Trigger tx | [trigger tx](https://polygonscan.com/tx/0xf1a218b773c8cab739f121d61857989b9eb756205314310ca9fe280cc56e2371) |
| USDT held on SWT contract after trigger | 0.66 USDT |
| Protocol-generated USDT on SWT contract | 0.658925 USDT0 |
| Post-test unwind status | Active |
| Latest unwind tx | [OKX sell tx](https://polygonscan.com/tx/0xa23b640502396ae5ce4627ae4af976dfe502fdf612b5b4eedfb3f39f0382beaa) |
| External route activity observed | Yes — arbitrage observed after sell-side checks |
| Founder-funded top-up | TBA / not included |
| First charity transfer test | TBA |
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
| 2026-05-12 | Test wallet | First POL → SWT swap | [swap 1](https://polygonscan.com/tx/0xd4700f018cddfca2281d5c3f4ea7e2ce45facf16419e4fb0622a47a20918fd54) | First controlled test swap executed |
| 2026-05-12 | Test wallet | Additional POL → SWT swap | [swap 2](https://polygonscan.com/tx/0x427856ae082b7022ce3cef8dd8d49bbe66448ffc9e642e81cb3d18739ceedbd7) | Controlled test swap executed |
| 2026-05-12 | Test wallet | Additional POL → SWT swap | [swap 3](https://polygonscan.com/tx/0xa6b780c5657ea5e49481ba26eef27a6edbd09dae78ebfc94b4bc8818840fc2ec) | Controlled test swap executed |
| 2026-05-12 | Test wallet | Uniswap POL → SWT swap | [swap 4](https://polygonscan.com/tx/0xd2b046cfa8cf48f6903cc44abdfc34bf0d0f084c315f5cd2bfb94120a9378933) | Direct pool-output route comparison; no additional SWT fee accumulation observed |
| 2026-05-12 | Test wallet | Uniswap POL → SWT swap | [swap 5](https://polygonscan.com/tx/0xa6a18989bbeed7010e4905375d06d7cbeb85d69a0fc37ba6fbb146cb9eca2410) | Direct pool-output route comparison; no additional SWT fee accumulation observed |
| 2026-05-12 | Test wallet | Uniswap POL → SWT swap | [swap 6](https://polygonscan.com/tx/0x4afb96d400261e13ad1b8c18949fd2d112c80eeefd24bc4598e20b89e73dcae3) | Second small-swap series completed; direct pool-output route behavior documented |
| 2026-05-12 | External wallet | MEV / Cross-pool re-alignment activity | [external tx 1](https://polygonscan.com/tx/0xda13d3c85fa459c6211c229fb9e1519fe3c2a36e4867aca7fbff2eee8c628e5d) | Observed after direct Uniswap-route swaps; not SWT team activity |
| 2026-05-12 | External wallet | Additional cross-pool re-alignment activity | [external tx 2](https://polygonscan.com/tx/0x56972b166cb55a4f37b096c072f2d703cca55a0b5660654c684cc945ee2fc105) | External market activity reduced the visible pool spread |
| 2026-05-13 | Test wallet | POL → USDT preparation swap | [prep tx](https://polygonscan.com/tx/0xc4bbc51d67f2abe1063345ce628f284101a6be95340664ffb75e01a5163eab9e) | Prepared USDT for MetaMask USDT → SWT route comparison; not an SWT fee event |
| 2026-05-13 | Test wallet | MetaMask USDT → SWT route comparison | [swap 7](https://polygonscan.com/tx/0x3466e4be7e892cf442369d20a17b8e7b2735e768ddaea5e0269a1705a1c81614) | Tested USDT input route behavior |
| 2026-05-13 | Test wallet | MetaMask USDT → SWT route comparison | [swap 8](https://polygonscan.com/tx/0xeb2e86dfa1bf8aa271aac73ae940b9da150359933727b700c07966264334cb5c) | Controlled USDT → SWT route comparison swap |
| 2026-05-13 | Test wallet | MetaMask USDT → SWT route comparison | [swap 9](https://polygonscan.com/tx/0xfe4d2b652816f6d720ce96010c62a1cd10d8c3daee63b7ecf5a8d8d3f0889a17) | USDT → SWT route comparison series completed |
| 2026-05-13 | Test wallet | MetaMask POL → SWT route repeat | [swap 10](https://polygonscan.com/tx/0xa10794cd7cb1f79fa4cce3922e88285f30bd0187df802559bb2ac860d0e6ce9e) | Repeated routed POL input after route-comparison results |
| 2026-05-13 | Test wallet | MetaMask POL → SWT route repeat | [swap 11](https://polygonscan.com/tx/0xa1c33a88997fceafd1c864d6e5903d4b358c3004c50f62c75d03172be96bc3df) | Controlled routed POL → SWT test swap |
| 2026-05-13 | Test wallet | MetaMask POL → SWT route repeat | [swap 12](https://polygonscan.com/tx/0x4ce62292d695f46f84c65cc880209d7ad5bc9d7cd651a6242bec257f0832fe8b) | Fourth small-swap series completed |
| 2026-05-13 | External wallet | MEV / cross-pool re-alignment activity | [external tx 3](https://polygonscan.com/tx/0xd42a935df9978863c2b5406fadeaef23acad38d9a1aeb1e56e5da2a51e504a83) | Observed during the fourth MetaMask POL → SWT series; not SWT team activity |
| 2026-05-13 | Test wallet | MetaMask POL → SWT route repeat | [swap 13](https://polygonscan.com/tx/0xe164eed76a356b1a699eedbfa59860312c15fed34d886fcd275ad02ee0f4bffa) | Fifth small-swap series started; routed POL input repeated |
| 2026-05-13 | Test wallet | MetaMask POL → SWT route repeat | [swap 14](https://polygonscan.com/tx/0xbac2c3eafb67bca9b45b08b0a7f5997a64176f2b6e1abf09c79fa25a9f7d4a85) | Controlled routed POL → SWT test swap |
| 2026-05-13 | Test wallet | MetaMask POL → SWT route repeat | [swap 15](https://polygonscan.com/tx/0xda6a482d9540dbf4dd6e1fa646d610ac214e3f81582a432ce606d0d6588e0391) | Fifth small-swap series completed |
| 2026-05-14 | Test wallet | MetaMask POL → SWT route repeat | [swap 16](https://polygonscan.com/tx/0x31da7b9ed537a280afb99c826377ef25b916c7a2a2eef5ca867dd8ed158ec683) | Sixth small-swap series started; routed POL input repeated |
| 2026-05-14 | Test wallet | MetaMask POL → SWT route repeat | [swap 17](https://polygonscan.com/tx/0x62f891d3bfd46e91a7f2a6fe3adecd732d26fa1ac0ea0043a35bd3e149b5c487) | Controlled routed POL → SWT test swap |
| 2026-05-14 | Test wallet | MetaMask POL → SWT route repeat | [swap 18](https://polygonscan.com/tx/0xb54ced5d3d6b714c05dec40a5398b461e5965045d62ad33083b7d87d546404d3) | Sixth small-swap series completed; threshold not reached |
| 2026-05-14 | Test wallet | MetaMask POL → SWT route repeat | [swap 19](https://polygonscan.com/tx/0x3226097ffcdb0716932e7070262e1627fba2028c407954ee7b460d4488833dab) | Seventh small-swap series started; routed POL input repeated |
| 2026-05-14 | Test wallet | MetaMask POL → SWT route repeat | [swap 20](https://polygonscan.com/tx/0x889eb8872f4f114693c566912621d091bb1cb3d395786629d71710110d8cc651) | Controlled routed POL → SWT test swap |
| 2026-05-14 | Test wallet | MetaMask POL → SWT route repeat | [swap 21](https://polygonscan.com/tx/0xd07c89aee6fc143e710a6578831c91ef261b5bfb5f712a55b5ba2bfb8a3592e0) | Seventh small-swap series completed; threshold not reached |
| 2026-05-14 | Test wallet | MetaMask POL → SWT route repeat | [swap 22](https://polygonscan.com/tx/0x85e42f455c3b8fce334a84248832d765d121d5a61efa420585ef09bc1e4769fb) | Eighth small-swap series started; routed POL input repeated |
| 2026-05-14 | Test wallet | MetaMask POL → SWT route repeat | [swap 23](https://polygonscan.com/tx/0xbf10be180605e1d68fbfd4ab4c4cd59b103ece809003270516edcfd9029c0aea) | Controlled routed POL → SWT test swap |
| 2026-05-14 | Test wallet | MetaMask POL → SWT route repeat | [swap 24](https://polygonscan.com/tx/0x5ba54538d6789e2214da46aec74b98a774472730d78407402775dab35d000d9a) | Eighth small-swap series completed; threshold reached |
| 2026-05-14 | SWT contract | Threshold reached | [THRESHOLD_SWAP](https://polygonscan.com/tx/0xbf10be180605e1d68fbfd4ab4c4cd59b103ece809003270516edcfd9029c0aea) | 50 SWT fee threshold reached; public trigger window opened |
| 2026-05-15 | Test wallet | `triggerCharity()` | [trigger tx](https://polygonscan.com/tx/0xf1a218b773c8cab739f121d61857989b9eb756205314310ca9fe280cc56e2371) | No external trigger occurred during the observation window; SWT completed the trigger step from the disclosed test wallet |
| 2026-05-15 | SWT contract | USDT received after trigger | [trigger tx](https://polygonscan.com/tx/0xf1a218b773c8cab739f121d61857989b9eb756205314310ca9fe280cc56e2371) | Protocol-generated USDT visible on contract: 0.66 USDT |
| 2026-05-16 | Test wallet | Post-test unwind — OKX route SWT → USDT0 | [tx](https://polygonscan.com/tx/0x2cb460e2b95c5fc64943f427ccb39d10f79cb9fd1b29b7c9eca70874eec57f7e) | 2,000 SWT sell-side check; 25.0095 USDT0 received; 2 SWT fee transfer observed |
| 2026-05-16 | External route / arbitrage | External arbitrage after OKX route | [tx](https://polygonscan.com/tx/0x48dcad5b55c31870b2a733b5fe6b39319aa99a24b41218ed241d96f0e8b42a57) | External pool-balancing activity observed; not initiated by SWT test wallet |
| 2026-05-16 | Test wallet | Post-test unwind — Uniswap route SWT → USDT0 | [tx](https://polygonscan.com/tx/0x3cb4f175e83594f19fef20ec7df57170eeadadc84ca328838298dbe00decc4b2) | 2,000 SWT direct sell; 24.604634 USDT0 received; no direct SWT fee observed |
| 2026-05-16 | External route / arbitrage | External arbitrage after Uniswap route | [tx](https://polygonscan.com/tx/0x337ad1819d41fc9325f40f559d40ebf85bef8cdc752029264583bfaef0d2a0c1) | External route added approximately 0.367156 SWT fee to the contract |
| 2026-05-16 UTC | Test wallet | Post-test unwind — OKX route SWT → USDT0 | [tx](https://polygonscan.com/tx/0x351e023ed457be5321ed2ef21bc6c384100093af7cb0451001e2b9c206626cb1) | 3,000 SWT sell-side check; 35.692174 USDT0 received; 3 SWT fee transfer observed |
| 2026-05-16 UTC | External route / arbitrage | External arbitrage after OKX route | [tx](https://polygonscan.com/tx/0xccc951ee6580a3e3294424545d22e4136b2d57f110d3258c19fb4a5f80634416) | External pool-balancing activity observed; not initiated by SWT test wallet |
| 2026-05-16 UTC | Test wallet | Post-test unwind — OKX route SWT → USDT0 | [tx](https://polygonscan.com/tx/0xa23b640502396ae5ce4627ae4af976dfe502fdf612b5b4eedfb3f39f0382beaa) | 3,000 SWT sell-side check; 34.56124 USDT0 received; 3 SWT fee transfer observed |
| 2026-05-16 UTC | External route / arbitrage | External arbitrage after OKX route | [tx](https://polygonscan.com/tx/0x0ec43e64a1ddd77bb001421b26f4385725944e894a89324de9851111e2531c226) | External pool-balancing activity observed; not initiated by SWT test wallet |
| TBA | Creator/admin wallet | Founder top-up, if used | TBA | To be reported separately from protocol-generated USDT |
| TBA | SWT contract / CharityAdmin | First charity transfer test | TBA | TBA |
| TBA | Recipient / donation platform | Receipt or public confirmation, if available | TBA | TBA |
| TBA | Test wallet | Position movement, if any | TBA | TBA |
| TBA | Test wallet | Additional SWT route-comparison swaps, if any | TBA | TBA |
| TBA | SWT contract | Threshold reached | TBA | 50 SWT fee threshold |

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

External market activity during the fourth series:

- MEV / cross-pool re-alignment tx: [external tx 3](https://polygonscan.com/tx/0xd42a935df9978863c2b5406fadeaef23acad38d9a1aeb1e56e5da2a51e504a83)

This activity is documented as external market-driven pool re-alignment. It is separate from the disclosed SWT Public Test Wallet activity and does not imply affiliation, endorsement, or participation by any external wallet.

Fifth small-swap series — MetaMask POL input repeat:

A fifth controlled small-swap series was executed from the disclosed SWT Public Test Wallet.

This series again repeated the MetaMask POL → SWT routed execution path after the earlier route-comparison observations.

Transactions:

- Swap 13: [swap 13](https://polygonscan.com/tx/0xe164eed76a356b1a699eedbfa59860312c15fed34d886fcd275ad02ee0f4bffa)
- Swap 14: [swap 14](https://polygonscan.com/tx/0xbac2c3eafb67bca9b45b08b0a7f5997a64176f2b6e1abf09c79fa25a9f7d4a85)
- Swap 15: [swap 15](https://polygonscan.com/tx/0xda6a482d9540dbf4dd6e1fa646d610ac214e3f81582a432ce606d0d6588e0391)

Series measurements:

- Accumulated SWT fee before series: 33.10 / 50 SWT
- Accumulated SWT fee after series: 38.05 / 50 SWT
- Observed fee delta: +4.95 SWT

Route observation:

The fifth series again produced additional SWT fee accumulation consistent with the earlier MetaMask-routed behavior.

Across the observed series, MetaMask-routed POL and USDT swaps repeatedly produced fee accumulation, while direct Uniswap pool-output swaps produced no additional SWT fee accumulation.

The current working observation is that SWT fee accumulation depends primarily on the actual SWT transfer path: transfers from fee-exempt pools can avoid fee accumulation, while transfers through non-exempt intermediate addresses can create it.

This observation is based on transaction logs and may be refined in the final report after full verification.

The trigger threshold has not been reached yet. `triggerCharity()` has not been executed.

### 2026-05-14 — Test update

Sixth small-swap series — MetaMask POL input repeat:

A sixth controlled small-swap series was executed from the disclosed SWT Public Test Wallet.

The test continued the repeated MetaMask POL → SWT routed execution path used in earlier comparison series.

Transactions:

- Swap 16: [swap 16](https://polygonscan.com/tx/0x31da7b9ed537a280afb99c826377ef25b916c7a2a2eef5ca867dd8ed158ec683)
- Swap 17: [swap 17](https://polygonscan.com/tx/0x62f891d3bfd46e91a7f2a6fe3adecd732d26fa1ac0ea0043a35bd3e149b5c487)
- Swap 18: [swap 18](https://polygonscan.com/tx/0xb54ced5d3d6b714c05dec40a5398b461e5965045d62ad33083b7d87d546404d3)

Series measurements:

- Accumulated SWT fee before series: 38.05 / 50 SWT
- Accumulated SWT fee after series: 42.74 / 50 SWT
- Observed fee delta: +4.69 SWT

Route observation:

The sixth series continued to show SWT fee accumulation under routed MetaMask execution.

The working observation remains that SWT fee behavior depends on the actual ERC-20 transfer path. Transfers involving recognized SWT/USDT pools are fee-exempt under the contract logic, while transfers through non-exempt intermediate addresses can create fee accumulation.

The trigger threshold has not been reached yet. `triggerCharity()` has not been executed.

Seventh small-swap series — MetaMask POL input repeat:

A seventh controlled small-swap series was executed from the disclosed SWT Public Test Wallet.

The test continued the repeated MetaMask POL → SWT routed execution path used in earlier comparison series.

Transactions:

- Swap 19: [swap 19](https://polygonscan.com/tx/0x3226097ffcdb0716932e7070262e1627fba2028c407954ee7b460d4488833dab)
- Swap 20: [swap 20](https://polygonscan.com/tx/0x889eb8872f4f114693c566912621d091bb1cb3d395786629d71710110d8cc651)
- Swap 21: [swap 21](https://polygonscan.com/tx/0xd07c89aee6fc143e710a6578831c91ef261b5bfb5f712a55b5ba2bfb8a3592e0)

Series measurements:

- Accumulated SWT fee before series: 42.74 / 50 SWT
- Accumulated SWT fee after series: 47.25 / 50 SWT
- Observed fee delta: +4.51 SWT

Route observation:

The seventh series continued to show SWT fee accumulation under routed MetaMask execution.

The working observation remains that SWT fee behavior depends on the actual ERC-20 `Transfer(from, to)` path. Transfers involving recognized SWT/USDT pools are fee-exempt under the contract logic, while transfers through non-exempt intermediate addresses can create fee accumulation.

Eighth small-swap series — MetaMask POL input repeat and threshold reached:

An eighth controlled small-swap series was executed from the disclosed SWT Public Test Wallet.

This series continued the repeated MetaMask POL → SWT routed execution path used in earlier comparison series.

Transactions:

- Swap 22: [swap 22](https://polygonscan.com/tx/0x85e42f455c3b8fce334a84248832d765d121d5a61efa420585ef09bc1e4769fb)
- Swap 23: [swap 23](https://polygonscan.com/tx/0xbf10be180605e1d68fbfd4ab4c4cd59b103ece809003270516edcfd9029c0aea)
- Swap 24: [swap 24](https://polygonscan.com/tx/0x5ba54538d6789e2214da46aec74b98a774472730d78407402775dab35d000d9a)

Series measurements:

- Accumulated SWT fee before series: 47.25 / 50 SWT
- Accumulated SWT fee after series: 51.68 / 50 SWT
- Observed fee delta: +4.43 SWT

Threshold state:

The 50 SWT trigger threshold was reached during this series.

- Threshold tx: [THRESHOLD_SWAP](https://polygonscan.com/tx/0xbf10be180605e1d68fbfd4ab4c4cd59b103ece809003270516edcfd9029c0aea)
- Public trigger window: opened
- `triggerCharity()` status: not executed yet
- Trigger tx: TBA
- USDT held on SWT contract after trigger: TBA

Route observation:

The eighth series continued to show SWT fee accumulation under routed MetaMask execution.

Across the observed series, MetaMask-routed POL and USDT swaps repeatedly produced fee accumulation, while direct Uniswap pool-output swaps produced no additional SWT fee accumulation.

The working observation remains that SWT fee behavior depends on the actual ERC-20 `Transfer(from, to)` path. Transfers involving recognized SWT/USDT pools are fee-exempt under the contract logic, while transfers through non-exempt intermediate addresses can create fee accumulation.

The next test phase is the permissionless trigger observation window. If an external wallet calls `triggerCharity()`, the transaction will be documented. If no external trigger occurs during the observation window, SWT may complete the mechanics test from a disclosed wallet.

### 2026-05-15 — Trigger execution

After the 50 SWT trigger threshold was reached, the public trigger window remained open for external execution.

No external trigger was observed during the public observation window.

SWT therefore completed the trigger step from the disclosed SWT Public Test Wallet.

Trigger transaction:

- `triggerCharity()`: [trigger tx](https://polygonscan.com/tx/0xf1a218b773c8cab739f121d61857989b9eb756205314310ca9fe280cc56e2371)

Post-trigger state:

- Trigger caller: disclosed SWT Public Test Wallet
- SWT accumulated fee before trigger window: 51.68 / 50 SWT
- Current accumulated SWT fee after trigger: 0.00 / 50 SWT
- USDT visible on SWT contract after trigger: 0.66 USDT
- Caller reward: 5 SWT
- Founder-funded top-up: not included in protocol-generated amount
- Charity transfer: not executed yet / TBA

Observation:

The public mechanics path was completed:

1. controlled swap activity;
2. SWT fee accumulation;
3. 50 SWT threshold reached;
4. public trigger window opened;
5. no external trigger observed;
6. `triggerCharity()` executed from the disclosed test wallet;
7. protocol-generated USDT became visible on-chain.

Any founder-funded top-up or later charity transfer will be documented separately. No top-up amount will be presented as protocol-generated donation output.

### 2026-05-16 — Post-test unwind window 1

After the initial public mechanics test was completed on 2026-05-15, SWT started a post-test position unwind from the disclosed SWT Public Test Wallet.

This activity is logged because it may affect fee accumulation, pool state, route behavior, and the next trigger cycle. It is not part of the initial trigger test cycle.

Pre-check:

- MetaMask sell route: not found at the time of testing
- No MetaMask sell transaction was executed

Sell-side checks:

1. OKX route — SWT → USDT0  
   - Tx: [OKX sell tx](https://polygonscan.com/tx/0x2cb460e2b95c5fc64943f427ccb39d10f79cb9fd1b29b7c9eca70874eec57f7e)
   - SWT input: 2,000 SWT
   - USDT0 received by test wallet: 25.0095 USDT0
   - Direct SWT fee observed: 2 SWT

2. Uniswap route — SWT → USDT0  
   - Tx: [Uniswap sell tx](https://polygonscan.com/tx/0x3cb4f175e83594f19fef20ec7df57170eeadadc84ca328838298dbe00decc4b2)
   - SWT input: 2,000 SWT
   - USDT0 received by test wallet: 24.604634 USDT0
   - Direct SWT fee observed: 0 SWT

External route activity:

- External arbitrage after OKX route: [tx](https://polygonscan.com/tx/0x48dcad5b55c31870b2a733b5fe6b39319aa99a24b41218ed241d96f0e8b42a57)
- External arbitrage after Uniswap route: [tx](https://polygonscan.com/tx/0x337ad1819d41fc9325f40f559d40ebf85bef8cdc752029264583bfaef0d2a0c1)
- The second observed arbitrage path added approximately 0.367156 SWT fee to the SWT contract.
- These external route transactions were not initiated by the SWT test wallet.

Observed state after window:

- Accumulated SWT fee before window: 0.00 / 50 SWT
- Accumulated SWT fee after window: 2.37 / 50 SWT
- Observed fee delta: +2.37 SWT
- Lifetime SWT collected: 54.04 SWT
- USDT0 visible on SWT contract: 0.66 USDT0
- Next trigger threshold reached: No

Observation:

Sell-side fee behavior again depended on the actual SWT transfer path.

The OKX route created a non-exempt SWT fee transfer. The direct Uniswap sell transferred SWT to the pool and did not add direct SWT fee. External arbitrage activity appeared after both sell-side checks, and one later route added additional SWT fee to the contract.

### 2026-05-16 — Post-test unwind window 2

A second post-test position unwind window was completed from the disclosed SWT Public Test Wallet.

This activity is logged because it may affect fee accumulation, pool state, route behavior, and the next trigger cycle. It is not part of the initial trigger test cycle, which was completed on 2026-05-15.

Sell-side checks:

1. OKX route — SWT → USDT0  
   - Tx: [OKX sell tx](https://polygonscan.com/tx/0x351e023ed457be5321ed2ef21bc6c384100093af7cb0451001e2b9c206626cb1)
   - SWT input: 3,000 SWT
   - USDT0 received by test wallet: 35.692174 USDT0
   - Direct SWT fee observed: 3 SWT

2. OKX route — SWT → USDT0  
   - Tx: [OKX sell tx](https://polygonscan.com/tx/0xa23b640502396ae5ce4627ae4af976dfe502fdf612b5b4eedfb3f39f0382beaa)
   - SWT input: 3,000 SWT
   - USDT0 received by test wallet: 34.56124 USDT0
   - Direct SWT fee observed: 3 SWT

External route activity:

- External arbitrage after first OKX sell: [tx](https://polygonscan.com/tx/0xccc951ee6580a3e3294424545d22e4136b2d57f110d3258c19fb4a5f80634416)
- External arbitrage after second OKX sell: [tx](https://polygonscan.com/tx/0x0ec43e64a1ddd77bb001421b26f4385725944e894a89324de9851111e2531c226)
- These external transactions were not initiated by the SWT test wallet.

Observed state after window:

- Accumulated SWT fee before window: 2.37 / 50 SWT
- Accumulated SWT fee after window: 8.37 / 50 SWT
- Observed fee delta: +6.00 SWT
- USDT0 received by test wallet during this window: 70.253414 USDT0
- Next trigger threshold reached: No

Observation:

The OKX route again produced fee-bearing SWT transfers. External arbitrage appeared after the sell-side checks, showing that pool state changes can lead to additional market activity outside the disclosed test wallet.

### 2026-05-18 — Final report

TBA

---

## Final summary

TBA

Series measurement summary:

| Series | Route tested | Accumulated fee before | Accumulated fee after | Observed fee delta |
|---|---|---:|---:|---:|
| 1 | MetaMask POL → SWT routed input | 16.88 SWT | 22.59 SWT | +5.71 SWT |
| 2 | Uniswap POL → SWT direct pool-output | 22.59 SWT | 22.59 SWT | +0.00 SWT |
| 3 | MetaMask USDT → SWT routed input | 22.59 SWT | 27.95 SWT | +5.36 SWT |
| 4 | MetaMask POL → SWT routed input repeat | 27.95 SWT | 33.10 SWT | +5.15 SWT |
| 5 | MetaMask POL → SWT routed input repeat | 33.10 SWT | 38.05 SWT | +4.95 SWT |
| 6 | MetaMask POL → SWT routed input repeat | 38.05 SWT | 42.74 SWT | +4.69 SWT |
| 7 | MetaMask POL → SWT routed input repeat | 42.74 SWT | 47.25 SWT | +4.51 SWT |
| 8 | MetaMask POL → SWT routed input repeat | 47.25 SWT | 51.68 SWT | +4.43 SWT |

Expected final summary fields:

- Test wallet disclosed before POL → SWT test swap activity: Yes
- Test wallet: `0x3020929156916c1f06120Efb033c8C61A7E1c208`
- Funding source disclosed: Yes — SWT creator/admin wallet `0xBc122bE1b62f0B8718C9dC9918ce2cd7C160BA07`
- Funding transaction documented: `0x82d222a13addfee7b157fe66c76307c6c5c989f9bc808ccdde8f0164ffa0b91d`
- Public test wallet funding amount: 5,000 POL
- POL → SWT execution path documented: TBA
- Swap activity documented: Yes — 24 controlled SWT swaps + 1 POL → USDT preparation tx
- SWT fee accumulation observed: Yes
- 50 SWT threshold reached: Yes
- `triggerCharity()` executed: No / pending
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
