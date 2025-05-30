#!/usr/bin/env bash
set -e

echo "🔧 Updating Homebrew..."
brew update

echo "📦 Installing or upgrading webp (cwebp)..."
if brew list webp &>/dev/null; then
  brew upgrade webp
else
  brew install webp
fi

echo "📦 Installing or upgrading ffmpeg (optional HEIC support)..."
if brew list ffmpeg &>/dev/null; then
  brew upgrade ffmpeg
else
  brew install ffmpeg
fi

echo "📁 Ensuring ~/scripts exists..."
mkdir -p "$HOME/scripts"

echo "⬇️  Downloading webpCreate…"
curl -fsSL https://raw.githubusercontent.com/chachwick/webpCreate/main/webpCreate \
  -o "$HOME/scripts/webpCreate"
chmod +x "$HOME/scripts/webpCreate"

echo "⬇️  Downloading update-webpCreate…"
curl -fsSL https://raw.githubusercontent.com/chachwick/webpCreate/main/update-webpCreate.sh \
  -o "$HOME/scripts/update-webpCreate"
chmod +x "$HOME/scripts/update-webpCreate"

# Add scripts dir to PATH if not already present
if ! grep -q 'export PATH="\$HOME/scripts:\$PATH"' "$HOME/.zshrc"; then
  echo 'export PATH="$HOME/scripts:$PATH"' >> "$HOME/.zshrc"
  echo "🛠  Added ~/scripts to your PATH in ~/.zshrc"
fi

# Add a convenient alias for updates
if ! grep -q 'alias update-webpCreate=' "$HOME/.zshrc"; then
  echo 'alias update-webpCreate="$HOME/scripts/update-webpCreate"' >> "$HOME/.zshrc"
  echo "🛠  Added alias \`update-webpCreate\` to ~/.zshrc"
fi

echo ""
echo "✅ Installation complete!"
echo "👉 Run \`source ~/.zshrc\` to load your new PATH and alias."
echo "👉 Then try \`webpCreate --help\` or \`update-webpCreate\`."
