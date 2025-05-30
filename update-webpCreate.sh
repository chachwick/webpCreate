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

echo "📄 Updating man page…"
MAN_DIR="/usr/local/share/man/man1"
mkdir -p "$MAN_DIR"
curl -fsSL https://raw.githubusercontent.com/chachwick/webpCreate/main/man/webpCreate.1 \
  -o "$MAN_DIR/webpCreate.1"
chmod 644 "$MAN_DIR/webpCreate.1"

echo ""
echo "✅ Update complete!"
echo "👉 Run \`source ~/.zshrc\` if you haven’t already."
echo "👉 Then try \`man webpCreate\` and \`webpCreate --help\`."
