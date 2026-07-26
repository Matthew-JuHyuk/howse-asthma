# UI design references (Subframe)

Patient-path layout references exported from Subframe, plus theme tokens.

**Basic design references** (not production / store approval). Use `/share`, not `/preview`.
Store-grade visual polish remains WBS **1.0c**.

- [SCR-AUTH-01](https://app.subframe.com/258df97c79f2/design/8c5c26ea-52ee-4343-bdaf-2e71ccd866e4/share) (splash / auth gate)
- [SCR-AUTH-02](https://app.subframe.com/258df97c79f2/design/6b714e5e-e1b6-4f6c-9845-b15e07064506/share) (login)
- [SCR-AUTH-03](https://app.subframe.com/258df97c79f2/design/40ca49c6-0a7d-4e12-b12e-e493d170996d/share) (sign up · role)
- [SCR-AUTH-04](https://app.subframe.com/258df97c79f2/design/926d2605-fdd7-4111-b2a2-af4b2e70c74d/share) (biometric lock)
- [SCR-ONB-01](https://app.subframe.com/258df97c79f2/design/71b2f283-e74c-4321-afae-ea365ec31667/share) (patient onboarding)
- [SCR-ONB-02](https://app.subframe.com/258df97c79f2/design/4ef8a2ae-375c-4ebb-afe6-0b9a54ff9118/share) (provider profile / NPI)
- [SCR-PAT-HOME](https://app.subframe.com/258df97c79f2/design/c38b4fed-7c1a-4771-935f-40371f29ed99/share) (PAT-01 CALM)
- [SCR-PAT-HOME.warn](https://app.subframe.com/258df97c79f2/design/1d6f6359-eb00-4a88-a9c4-7b24daeb968c/share) (PAT-01 WARNING)
- [SCR-PAT-ENV](https://app.subframe.com/258df97c79f2/design/81c056df-81db-4867-9750-dc96449c269e/share) (PAT-05~08)
- [SCR-PAT-FORECAST](https://app.subframe.com/258df97c79f2/design/728c437b-2169-4932-a303-5ad82b7c8ede/share) (PAT-06/08)
- [SCR-PAT-LOG](https://app.subframe.com/258df97c79f2/design/0f2ae00d-743e-43d9-a9e4-33b4f860f25b/share) (PAT-02)
- [SCR-SYS-PANIC](https://app.subframe.com/258df97c79f2/design/c39e11ac-5ef4-4e9a-98f9-c11c37b5a045/share) (emergency Step1+2 / UX-Q1)
- [SCR-SYS-PANIC.step2](https://app.subframe.com/258df97c79f2/design/9f832fb8-e95a-4c0e-b7a1-e4def80459d4/share) (Call for Help / no auto-dial)
- [SCR-PAT-ACT](https://app.subframe.com/258df97c79f2/design/ce348cf8-039e-4b9f-81b6-7ef43a49a25d/share) (PAT-03 ACT)
- [SCR-PAT-PDC](https://app.subframe.com/258df97c79f2/design/ede456eb-22aa-416a-b4f1-a9df5aba1e94/share) (PAT-03 PDC)
- [SCR-PAT-REPORT](https://app.subframe.com/258df97c79f2/design/fb8cbdd5-0ed0-49f0-a75d-22aa31427ac5/share) (evidence summary)
- [SCR-PAT-LOCATIONS](https://app.subframe.com/258df97c79f2/design/3a5ea1af-7850-472c-822d-c48f1742ac73/share) (PAT-10)
- [SCR-PAT-REWARD](https://app.subframe.com/258df97c79f2/design/134a0e89-6a54-44f5-bca2-90d9b65ae389/share) (RWD hub)
- [SCR-PAT-VOUCHER](https://app.subframe.com/258df97c79f2/design/552e0420-8909-45aa-a0d2-9288d502cddd/share) (RWD-02 waitlist)
- [SCR-PAT-DONATE](https://app.subframe.com/258df97c79f2/design/0e75bf74-5348-4a54-ab64-60d2809fe129/share) (DON-01~02 / RWD-03)
- [SCR-PAT-REWARD-HIST](https://app.subframe.com/258df97c79f2/design/be45d22c-31f6-43ce-8db4-479925ff082d/share) (RWD-04 / DON-03 history)
- [SCR-PAT-SETTINGS](https://app.subframe.com/258df97c79f2/design/543f6dac-75ce-490c-8efb-3b84b44d1701/share) (patient settings)
- [SCR-SYS-ALERT](https://app.subframe.com/258df97c79f2/design/94b3cb00-ca00-438a-8c35-9fcf3c2ee0ec/share) (risk alert landing)

See [`INDEX.md`](./INDEX.md).

## Layout

```text
design/subframe/
├── README.md / INDEX.md / PROJECT.json
├── docs/PAGE_IDS.json     # Screen ID → Subframe page id
├── theme/                 # Color / breakpoint tokens
└── react-reference/       # Patient, auth, and system screens
```

## Device preview (optional)

```powershell
# In .env: DESIGN_PREVIEW=true
flutter run
```

Opens `lib/features/design_preview/` for navigation flow checks. Set `DESIGN_PREVIEW=false` for the normal auth entry path.
