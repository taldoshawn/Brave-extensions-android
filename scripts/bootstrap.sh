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

if ! command -v pnpm >/dev/null 2>&1; then
  echo "pnpm is required. Install pnpm 11.11.0 before running bootstrap." >&2
  exit 2
fi

echo "==> Brave pin: $(git rev-parse HEAD)"
echo "==> pnpm: $(pnpm --version)"
echo "==> Initializing Android/ARM64 checkout"

pnpm run init -- \
  --target_os=android \
  --target_arch=arm64

echo
echo "Bootstrap complete."
echo "Next: bash scripts/build_android.sh"
