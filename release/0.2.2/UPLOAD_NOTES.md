# v0.2.2 Upload Notes

## Release Artifacts

- release/banks/app-0.2.2-saa.apk
- release/banks/app-0.2.2-sap.apk
- release/banks/app-0.2.2-ispm.apk

## Reproducible Commands

```powershell
# 1) Build ISPM bank assets from corrected source
.\scripts\prepare_ispm_bank.ps1 -PdfRoot "题库\ISPM_ocr_pdfsandwich"

# 2) Build three Android bank variants
.\scripts\build_android_bank_variant.ps1 -Bank saa -VersionTag 0.2.2
.\scripts\build_android_bank_variant.ps1 -Bank sap -VersionTag 0.2.2
.\scripts\build_android_bank_variant.ps1 -Bank ispm -VersionTag 0.2.2

# 3) Validate Flutter project
flutter analyze

# 4) Draft release tag (local)
git tag -a v0.2.2 -m "release: v0.2.2"
```

## Web Entry Routing Check

Root index links exist for:

- /saa/
- /sap/
- /ispm/
