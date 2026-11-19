#!/usr/bin/env bash
# Packages the plugin into dist/master-michi.plugin (a zip of the plugin files).
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p dist
rm -f dist/master-michi.plugin
zip -rq dist/master-michi.plugin .claude-plugin skills agents README.md LICENSE -x "*.DS_Store"
echo "Built dist/master-michi.plugin"
