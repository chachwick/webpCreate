#!/bin/bash

set -e

echo "🔧 Updating Homebrew..."
brew update

echo "📦 Installing or upgrading webp (includes cwebp)..."
brew list webp &>/dev/null && brew upgrade webp || brew install webp

echo "📁 Creating ~/scripts directory..."
mkdir -p "$HOME/scripts"

echo "⬇️  Downloading webpCreate script from GitHub..."
curl -fsSL https://raw.githubusercontent.com/chachwick/webpCreate/main/webpCreate > "$HOME/scripts/webpCreate"

echo "🔐 Making script executable..."
chmod +x "$HOME/scripts/webpCreate"

# Add to PATH only if not already present
if ! grep -q 'export PATH="$HOME/scripts:$PATH"' "$HOME/.zshrc"; then
  echo 'export PATH="$HOME/scripts:$PATH"' >> "$HOME/.zshrc"
  echo "🛠  Added ~/scripts to your PATH in ~/.zshrc"
fi

echo ""
echo "✅ Done!"
echo "➡️  Run the following to use webpCreate:"
echo ""
echo "   source ~/.zshrc"
echo "   cd /path/to/images"
echo "   webpCreate"
