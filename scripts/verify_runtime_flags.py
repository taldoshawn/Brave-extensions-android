#!/usr/bin/env python3
from pathlib import Path
import os
import re
import sys

project_root = Path(__file__).resolve().parents[1]
work_root = Path(os.environ.get(
    "BRAVE_MOBILE_EXT_WORK_ROOT",
    project_root / ".brave-work"
))
brave_dir = work_root / "brave-core"
src = brave_dir / "src"

upstream_flags = src / "extensions" / "buildflags" / "buildflags.gni"

errors = []

if upstream_flags.exists():
    text = upstream_flags.read_text(encoding="utf-8")
    required = [
        "enable_desktop_android_extensions",
        "enable_extensions_core",
    ]
    for token in required:
        if token not in text:
            errors.append(f"missing upstream token: {token}")
else:
    print(f"[info] upstream file not present yet: {upstream_flags}")

args_files = sorted((src / "out").glob("*/args.gn")) if (src / "out").exists() else []

if not args_files:
    print("[info] no generated args.gn found yet; source-level check only.")
else:
    matching = []
    for args in args_files:
        text = args.read_text(encoding="utf-8", errors="replace")
        desktop_ext = re.search(
            r"^\s*enable_desktop_android_extensions\s*=\s*true\s*$",
            text,
            re.MULTILINE,
        )
        mobile_form = re.search(
            r"^\s*is_desktop_android\s*=\s*false\s*$",
            text,
            re.MULTILINE,
        )
        if desktop_ext and mobile_form:
            matching.append(args)

    if matching:
        print("[ok] generated GN args preserve mobile UI and enable Android extensions:")
        for path in matching:
            print(f"     {path}")
    else:
        errors.append(
            "no args.gn contains both "
            "enable_desktop_android_extensions=true and is_desktop_android=false"
        )

if errors:
    print("[FAIL]")
    for error in errors:
        print(f" - {error}")
    sys.exit(1)

print("[ok] extension runtime configuration check passed")
