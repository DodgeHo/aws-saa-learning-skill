# v0.2.2 Draft

## Highlights

- Rebuilt ISPM bank from corrected OCR source set under `题库/ISPM_ocr_pdfsandwich`.
- Fixed ISPM type classification so question rendering correctly distinguishes objective/case/essay.
- Improved objective parsing for `试题 N` structure and inline option rows.
- Kept database schema unchanged; delivery continues via full asset-bundle replacement.
- Promoted ISPM release artifact naming from experimental to stable (`ispm`).

## Bank Build Snapshot

- ISPM manifest: `assets/banks/ispm/manifest.json`
- Questions total: `769`
- Type breakdown:
  - objective: `715`
  - case: `42`
  - essay: `12`

## Validation Evidence

- `flutter analyze`: passed (no issues)
- Bank switch workflow: validated in sequence (`saa` -> `sap` -> `ispm`)
- Android bank variants built:
  - `release/banks/app-0.2.2-saa.apk`
  - `release/banks/app-0.2.2-sap.apk`
  - `release/banks/app-0.2.2-ispm.apk`

## Notes and Risk

- OCR noise still exists in some ISPM rows; objective answer extraction currently covers most but not all rows.
- Suggested follow-up: add a targeted OCR post-clean pass for the remaining missing answer keys.

## Suggested Release Tag

- `v0.2.2`
- title: `0.2.2 - ISPM bank rebuild`
- scope: include SAA/SAP/ISPM Android variant artifacts listed above.
