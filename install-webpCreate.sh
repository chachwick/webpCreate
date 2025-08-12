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

echo "📦 Installing or upgrading exiftool..."
if brew list exiftool &>/dev/null; then
  brew upgrade exiftool
else
  brew install exiftool
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

echo "📄 Installing man page…"
BREW_PREFIX=$(brew --prefix)
MAN_DIR="$BREW_PREFIX/share/man/man1"
mkdir -p "$MAN_DIR"
curl -fsSL https://raw.githubusercontent.com/chachwick/webpCreate/main/man/webpCreate.1 \
  -o "$MAN_DIR/webpCreate.1"
chmod 644 "$MAN_DIR/webpCreate.1"

# Update ~/.zshrc
if ! grep -q 'export PATH="$HOME/scripts:$PATH"' "$HOME/.zshrc"; then
  echo 'export PATH="$HOME/scripts:$PATH"' >> "$HOME/.zshrc"
  echo "🛠  Added ~/scripts to your PATH in ~/.zshrc"
fi

if ! grep -q 'alias update-webpCreate=' "$HOME/.zshrc"; then
  echo 'alias update-webpCreate="$HOME/scripts/update-webpCreate"' >> "$HOME/.zshrc"
  echo "🛠  Added alias update-webpCreate to ~/.zshrc"
fi

echo ""
echo "✅ Installation complete!"
echo "👉 Run \`source ~/.zshrc\` to load your new PATH and alias."
echo "👉 Then try \`man webpCreate\` and \`webpCreate --help\`."
