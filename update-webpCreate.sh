#!/usr/bin/env bash
set -e

echo "🔄 Updating webpCreate…"
curl -fsSL https://raw.githubusercontent.com/chachwick/webpCreate/main/webpCreate \
  -o "$HOME/scripts/webpCreate"
chmod +x "$HOME/scripts/webpCreate"

echo "✅ webpCreate has been updated."
