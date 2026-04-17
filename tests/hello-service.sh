#!/bin/bash
#
# Smoke test: Create an HTTP hello world service and verify it responds.
# Runs the step scripts from wso2ipw examples/hello-world-service/.
#
set -euo pipefail

EXAMPLES_DIR="$(npm root -g)/wso2ipw/examples/hello-world-service"

fail() {
  echo "FAIL: $1" >&2
  wso2ipw screenshot failure-$(date +%s).png 2>/dev/null || true
  wso2ipw close 2>/dev/null
  exit 1
}

for step in "$EXAMPLES_DIR"/0*.sh; do
  name=$(basename "$step")
  echo "═══ $name ═══"
  bash "$step" || fail "$name"
  echo "✓ $name"
done

echo ""
echo "════════════════════════════════════════════"
echo "  SMOKE TEST PASSED ✓"
echo "════════════════════════════════════════════"

wso2ipw close 2>/dev/null || true
