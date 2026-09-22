#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "${SCRIPT_DIR}/common.sh"

if [[ ! -f "${CHROMIUM_SRC}/BUILD.gn" ]]; then
  echo "Run bash scripts/bootstrap.sh first." >&2
  exit 2
fi

cd "${BRAVE_DIR}"

pnpm run build \
  --target_os=android \
  --target_arch=arm64 \
  --target_android_output_format=apk \
  --prepare_only \
  --gn enable_desktop_android_extensions:true \
  --gn is_desktop_android:false

python3 "${PROJECT_ROOT}/scripts/verify_runtime_flags.py"
