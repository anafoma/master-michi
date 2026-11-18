#!/usr/bin/env bash
# Packages the plugin into dist/stormwake.plugin (a zip of the plugin files).
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p dist
rm -f dist/stormwake.plugin
zip -rq dist/stormwake.plugin .claude-plugin skills agents README.md LICENSE -x "*.DS_Store"
echo "Built dist/stormwake.plugin"
