# Brave Mobile Extensions

Experimental engineering layer for enabling Chromium's Android extension runtime
inside the normal **mobile** Brave UI.

## Current status

Phase 0 is implemented: build Brave for Android/ARM64 with Chromium's experimental
Android extension runtime enabled while explicitly keeping `is_desktop_android=false`.

This is deliberate. Chromium currently defines:

- `enable_desktop_android_extensions`
- `enable_extensions_core = enable_extensions || enable_desktop_android_extensions`

The first build therefore does **not** patch Chromium. It overrides the existing GN
argument so we can identify the real compile/runtime gaps on phone-form-factor Android.

Pinned baseline:

- Brave core: `9a3f6bf22e02942d28051eb90f6d33f90b702437`
- Brave version at that baseline: `1.98.17`
- Chromium: `154.0.8037.49`

## What this first build enables

The build command passes:

```text
enable_desktop_android_extensions=true
is_desktop_android=false
```

Expected consequences in Chromium:

- `enable_extensions_core=true`
- extension browser/runtime targets are compiled
- Android-specific extension implementations are selected
- `chrome://extensions` WebUI dependencies are pulled in
- Android extension UI/runtime dependencies guarded by
  `enable_desktop_android_extensions` are pulled in

It intentionally does **not** turn the whole browser into the desktop Android UI.

## Local build

A full Brave/Chromium checkout is very large. Use a Linux machine with substantial
free disk space.

```bash
./scripts/bootstrap.sh
./scripts/build_android.sh
```

After GN generation/build preparation, inspect the generated args:

```bash
python3 scripts/verify_runtime_flags.py
```

## Test extension

`test-extension/` contains a small Manifest V3 extension used as our smoke test.
It:

- injects a tiny page marker
- has an action popup
- uses `storage`
- uses `scripting`
- uses `activeTab`

Once an APK with extension loading is available, this is the first extension to load
through `chrome://extensions` / Load unpacked.

## GitHub Actions

Two workflows are included:

- `smoke.yml` — cheap repository checks on normal GitHub-hosted runners.
- `android-build.yml` — full Brave build.

## Next engineering checkpoint

The first full build tells us which of these paths is true:

1. **Best case:** Brave mobile compiles with the runtime flag as-is. Then the next
   commit adds a native Brave menu entry for Extensions and installation UX.
2. **Expected case:** a handful of Chromium targets assume
   `enable_desktop_android_extensions => is_desktop_android`. We patch only those
   exact assumptions.
3. **Hard case:** Chrome's Android windowing/toolbar extension UI still depends on
   desktop-form-factor classes. We keep the extension engine and implement a thin
   Brave-mobile UI bridge instead.

See `ROADMAP.md`.
