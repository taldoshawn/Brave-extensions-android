# First build checkpoint

The first build is intentionally designed to answer one question:

> Can Chromium 154's Android extension runtime compile inside normal phone-form-factor
> Brave when `enable_desktop_android_extensions=true` but `is_desktop_android=false`?

Do not add broad Kiwi-derived patches before this checkpoint. Chromium already has a
large amount of Android-specific extension code in 2026, so copying old patch sets
would make the fork harder to maintain.

## Commands

```bash
./scripts/bootstrap.sh
./scripts/build_android.sh
```

If the build fails, preserve:

1. the first compile/link error;
2. the target name;
3. about 100 lines surrounding the error;
4. `args.gn`.

That failure becomes the basis for the next minimal patch.

## Useful manual check

After sync:

```bash
grep -n "enable_desktop_android_extensions" \
  .brave-work/brave-core/src/extensions/buildflags/buildflags.gni
```

The upstream default should still reference `is_desktop_android`. We override it via
GN args rather than editing the file.
