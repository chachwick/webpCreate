#!/usr/bin/env bash
set -e

echo "🔄 Fetching latest webpCreate…"
curl -fsSL https://raw.githubusercontent.com/chachwick/webpCreate/main/webpCreate \
  -o "$HOME/scripts/webpCreate"
chmod +x "$HOME/scripts/webpCreate"

echo "🔄 Fetching latest update-webpCreate…"
curl -fsSL https://raw.githubusercontent.com/chachwick/webpCreate/main/update-webpCreate.sh \
  -o "$HOME/scripts/update-webpCreate"
chmod +x "$HOME/scripts/update-webpCreate"

echo
echo "✅ Update complete!"
echo '👉 Run `source ~/.zshrc` to load your new PATH and alias.'
echo '👉 Then try `webpCreate --help`.'
