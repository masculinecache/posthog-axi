#!/usr/bin/env bash
set -euo pipefail

PASS=0
FAIL=0

assert() {
  local desc="$1" actual="$2" expected="$3"
  if [ "$actual" = "$expected" ]; then
    PASS=$((PASS + 1))
  else
    FAIL=$((FAIL + 1))
    echo "FAIL: $desc"
    echo "  expected: $expected"
    echo "  actual:   $actual"
  fi
}

BIN="./posthog-axi"

# Version
v=$("$BIN" --version)
assert "version flag" "$v" "posthog-axi 0.1.0"

# Home view contains key elements
home=$("$BIN" 2>&1 || true)
echo "$home" | grep -q "description:" || { FAIL=$((FAIL + 1)); echo "FAIL: home missing description"; }
echo "$home" | grep -q "commands\[" || { FAIL=$((FAIL + 1)); echo "FAIL: home missing commands table"; }
echo "$home" | grep -q "flags" || { FAIL=$((FAIL + 1)); echo "FAIL: home missing flags command"; }
echo "$home" | grep -q "insights" || { FAIL=$((FAIL + 1)); echo "FAIL: home missing insights command"; }

# Unknown command fails with usage
err=$("$BIN" nonexistent 2>&1) && rc=0 || rc=$?
assert "unknown command exits non-zero" "$rc" "2"

# Call without required args
err=$("$BIN" call 2>&1) && rc=0 || rc=$?
assert "call without args exits non-zero" "$rc" "2"

# Search without pattern
err=$("$BIN" search 2>&1) && rc=0 || rc=$?
assert "search without pattern exits non-zero" "$rc" "2"

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ] || exit 1
