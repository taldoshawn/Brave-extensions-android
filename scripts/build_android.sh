#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "${SCRIPT_DIR}/common.sh"

if [[ ! -d "${BRAVE_DIR}/src" ]]; then
  echo "Brave checkout is not initialized. Run ./scripts/bootstrap.sh first." >&2
  exit 2
fi

cd "${BRAVE_DIR}"

echo "==> Building normal mobile Brave + Chromium Android extensions runtime"
echo "    enable_desktop_android_extensions=true"
echo "    is_desktop_android=false"

pnpm run build -- \
  --target_os=android \
  --target_arch=arm64 \
  --target_android_output_format=apk \
  --gn enable_desktop_android_extensions:true \
  --gn is_desktop_android:false

python3 "${PROJECT_ROOT}/scripts/verify_runtime_flags.py"

echo
echo "Build command finished. APK candidates:"
find "${BRAVE_DIR}/src/out" -type f \( -name '*.apk' -o -name '*.aab' \) -print 2>/dev/null | sort || true
