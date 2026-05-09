#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "=== Frontend Quality Checks ==="

echo ""
echo "-- Prettier (format check) --"
npx prettier --check "frontend/**/*.{html,js,css}"

echo ""
echo "-- ESLint (JS linting) --"
npx eslint frontend/script.js

echo ""
echo "All checks passed."
