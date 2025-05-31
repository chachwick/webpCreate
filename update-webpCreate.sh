#!/usr/bin/env bash
set -e

show_help() {
  cat <<-EOF
Usage: update-webpCreate [options]

Fetch the latest webpCreate, update-webpCreate, and man-page from GitHub.

Options:
  -h, --help       Show this help and exit
  -v, --version    Print the currently installed webpCreate version and exit
  -q, --quiet      Suppress update messages (no progress output)

Examples:
  update-webpCreate
  update-webpCreate --quiet
  update-webpCreate --version
EOF
}

QUIET=false
while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help) show_help; exit 0;;
    -v|--version)
      if [[ -f "$HOME/scripts/webpCreate" ]]; then
        grep -m1 '^# webpCreate version:' "$HOME/scripts/webpCreate" \
          | cut -d':' -f2 | xargs
      else
        echo "webpCreate not installed."
      fi
      exit 0
      ;;
    -q|--quiet) QUIET=true; shift;;
    --) shift; break;;
    -*) echo "Unknown option: $1"; exit 1;;
    *) break;;
  esac
done

# Only print a message if not in quiet mode
if [[ $QUIET == false ]]; then
  echo "🔄 Fetching latest webpCreate…"
fi
curl -fsSL https://raw.githubusercontent.com/chachwick/webpCreate/main/webpCreate \
  -o "$HOME/scripts/webpCreate"
chmod +x "$HOME/scripts/webpCreate"

if [[ $QUIET == false ]]; then
  echo "🔄 Fetching latest update-webpCreate…"
fi
curl -fsSL https://raw.githubusercontent.com/chachwick/webpCreate/main/update-webpCreate.sh \
  -o "$HOME/scripts/update-webpCreate"
chmod +x "$HOME/scripts/update-webpCreate"

# Update man page
BREW_PREFIX=$(brew --prefix)
MAN_DIR="$BREW_PREFIX/share/man/man1"
mkdir -p "$MAN_DIR"
if [[ $QUIET == false ]]; then
  echo "📄 Updating man page…"
fi
curl -fsSL https://raw.githubusercontent.com/chachwick/webpCreate/main/man/webpCreate.1 \
  -o "$MAN_DIR/webpCreate.1"
chmod 644 "$MAN_DIR/webpCreate.1"

if [[ $QUIET == false ]]; then
  echo ""
  echo "✅ Update complete!"
  echo "👉 Run \`source ~/.zshrc\` if you haven’t already."
  echo "👉 Then try \`man webpCreate\` and \`webpCreate --help\`."
  echo "👉 If you need to update dependencies as well, run:"
  echo "   bash <(curl -fsSL https://raw.githubusercontent.com/chachwick/webpCreate/main/install-webpCreate.sh)"
fi
