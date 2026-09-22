#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck disable=SC1091
source "${PROJECT_ROOT}/UPSTREAM_PIN.env"

WORK_ROOT="${BRAVE_MOBILE_EXT_WORK_ROOT:-${PROJECT_ROOT}/.brave-work}"
BRAVE_DIR="${WORK_ROOT}/brave-core"

export PROJECT_ROOT WORK_ROOT BRAVE_DIR
