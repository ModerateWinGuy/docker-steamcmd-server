#!/bin/bash
# Self-check for ini-utils.sh - run manually: bash scripts/test-ini-utils.sh
set -e
cd "$(dirname "$0")"
source ./ini-utils.sh

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT
cat > "$tmp" <<'EOF'
OptionSettings=(Difficulty=None,RCONPort=25575,ServerName="Default Palworld Server")
EOF

set_ini_value "$tmp" "RCONPort" "38212" > /dev/null
set_ini_value "$tmp" "ServerName" "PalworldServer" true > /dev/null
set_ini_value "$tmp" "PublicPort" "38211" > /dev/null

grep -q "RCONPort=38212" "$tmp" || { echo "FAIL: existing numeric key not updated"; exit 1; }
grep -q 'ServerName="PalworldServer"' "$tmp" || { echo "FAIL: existing quoted key not updated"; exit 1; }
grep -q "PublicPort=38211" "$tmp" || { echo "FAIL: new key not appended"; exit 1; }

echo "OK"
