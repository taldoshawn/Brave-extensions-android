#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "${SCRIPT_DIR}/common.sh"

mkdir -p "${WORK_ROOT}"

if [[ ! -d "${BRAVE_DIR}/.git" ]]; then
  git clone "${BRAVE_REPO}" "${BRAVE_DIR}"
fi

git -C "${BRAVE_DIR}" fetch --depth=1 origin "${BRAVE_REF}"
git -C "${BRAVE_DIR}" checkout --detach "${BRAVE_REF}"

cd "${BRAVE_DIR}"

if command -v corepack >/dev/null 2>&1; then
  corepack enable
fi

echo "==> Brave pin: $(git rev-parse HEAD)"
echo "==> Initializing Android/ARM64 checkout"

pnpm run init -- \
  --target_os=android \
  --target_arch=arm64

echo
echo "Bootstrap complete."
echo "Next: ./scripts/build_android.sh"
