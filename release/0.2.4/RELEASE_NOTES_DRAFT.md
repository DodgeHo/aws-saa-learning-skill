# 0.2.4 Release Notes (Draft)

## Highlights
- Fixed bank-specific naming across app and web title display.
- Added bank-aware Windows packaging script and corrected executable names per bank.

## Naming Fixes
- App title now follows active bank:
  - `SAA 练习`
  - `SAP 练习`
  - `ISPM 练习`
- Web title now reads `assets/active_bank.txt` to set browser title dynamically.

## Windows Artifacts
- `app-0.2.4-saa-windows-x64.zip` (contains `aws_saa_trainer.exe`)
- `app-0.2.4-sap-windows-x64.zip` (contains `aws_sap_trainer.exe`)
- `app-0.2.4-ispm-windows-x64.zip` (contains `ispm_trainer.exe`)

## Android Artifacts
- `app-0.2.4-saa.apk`
- `app-0.2.4-sap.apk`
- `app-0.2.4-ispm.apk`
