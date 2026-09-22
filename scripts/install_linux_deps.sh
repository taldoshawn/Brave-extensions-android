#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "${SCRIPT_DIR}/common.sh"

INSTALLER="${CHROMIUM_SRC}/build/install-build-deps.sh"
if [[ ! -x "${INSTALLER}" ]]; then
  echo "Chromium dependency installer not found. Run bootstrap first." >&2
  exit 2
fi

sudo "${INSTALLER}" --android --no-prompt
