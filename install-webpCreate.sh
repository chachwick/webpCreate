#!/usr/bin/env bash
set -e

# install-webpCreate.sh
# Bootstrap installer for webpCreate script and dependencies

# 1. Update Homebrew
echo "🔧 Updating Homebrew..."
brew update

# 2. Install or upgrade WebP (cwebp) and ffmpeg for HEIC support
echo "📦 Ensuring required packages are installed..."
if brew list webp &>/dev/null; then
  brew upgrade webp
else
  brew install webp
fi

if brew list ffmpeg &>/dev/null; then
  brew upgrade ffmpeg
else
  brew install ffmpeg
fi

# 3. Create scripts directory
echo "📁 Creating ~/scripts directory..."
mkdir -p "$HOME/scripts"

# 4. Download webpCreate script
echo "⬇️  Downloading webpCreate..."
curl -fsSL https://raw.githubusercontent.com/chachwick/webpCreate/main/webpCreate \
  -o "$HOME/scripts/webpCreate"

# 5. Make it executable
echo "🔐 Making webpCreate executable..."
chmod +x "$HOME/scripts/webpCreate"

# 6. Ensure PATH includes scripts directory
RCFILE="$HOME/.zshrc"
if ! grep -q 'export PATH="$HOME/scripts:$PATH"' "$RCFILE"; then
  echo 'export PATH="$HOME/scripts:$PATH"' >> "$RCFILE"
  echo "🛠 Added ~/scripts to PATH in $RCFILE"
fi

# 7. Final message
cat << EOF
✅ Installation complete!

Next steps:
  1. Reload your shell:
       source ~/.zshrc
  2. Verify installation:
       webpCreate -?                # Show help and usage
  3. Run webpCreate in any image folder:
       cd /path/to/images
       webpCreate [options]

For more details, visit:
  https://github.com/chachwick/webpCreate
EOF
