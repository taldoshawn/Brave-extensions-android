# Roadmap

## Phase 0 — Build the real runtime

- [x] Pin a current Brave/Chromium baseline
- [x] Keep normal Android mobile form factor
- [x] Enable `enable_desktop_android_extensions`
- [x] Add reproducible build scripts
- [x] Add a Manifest V3 smoke-test extension
- [x] Add CI scaffolding
- [ ] Run the first full compile and capture the first failing target, if any

## Phase 1 — Runtime boot

Goal: an APK that starts normally and initializes the extensions subsystem.

Checks:

- `ENABLE_EXTENSIONS_CORE=1`
- normal Brave tabs still work
- normal Brave Shields still work
- profile startup succeeds
- extension registry is available
- `chrome://extensions` resolves instead of "page unavailable"

## Phase 2 — Load unpacked

Goal: install the repository's `test-extension/`.

Work items:

- expose Android document/directory picker
- bridge selected directory to Chromium extension loader
- support Manifest V3 first
- show install/manifest errors in Android UI
- persist installed extension across restart

## Phase 3 — Mobile extensions UI

Add a Brave menu item:

`Menu -> Extensions`

First screen:

- installed extensions
- enabled toggle
- details
- remove
- load unpacked
- developer mode

Then add extension action UI:

- toolbar/menu action list
- popup WebContents
- site access controls
- permissions

## Phase 4 — CRX/Web Store

- CRX installation path
- update service
- Chrome Web Store compatibility where technically/legal-policy appropriate
- extension update UX

## Phase 5 — Compatibility

Priority APIs:

- runtime
- tabs
- storage
- scripting
- activeTab
- cookies
- webNavigation
- declarativeNetRequest
- downloads
- notifications

Manifest V3 is the primary target. MV2 support is explicitly not a Phase-1 goal.
