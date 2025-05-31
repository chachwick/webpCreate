#!/usr/bin/env bash
set -e

show_help() {
  cat <<-EOF
Usage: update-webpCreate [options]

Fetch the latest webpCreate, update-webpCreate, and man-page from GitHub.

Options:
  -h, --help       Show this help and exit
  -v, --version    Print the installed webpCreate version and exit
  -q, --quiet      Suppress progress output
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

download_and_replace() {
  local url=$1 dst=$2

  # Download into a temp file next to the destination
  local tmp="${dst}.new"
  curl -fsSL "$url" -o "$tmp"
  chmod +x "$tmp"
  mv "$tmp" "$dst"
}

if [[ $QUIET == false ]]; then
  echo "🔄 Fetching latest webpCreate…"
fi
download_and_replace \
  "https://raw.githubusercontent.com/chachwick/webpCreate/main/webpCreate" \
  "$HOME/scripts/webpCreate"

if [[ $QUIET == false ]]; then
  echo "🔄 Fetching latest update-webpCreate…"
fi
download_and_replace \
  "https://raw.githubusercontent.com/chachwick/webpCreate/main/update-webpCreate.sh" \
  "$HOME/scripts/update-webpCreate"

# Update man page
BREW_PREFIX=$(brew --prefix)
MAN_DIR="$BREW_PREFIX/share/man/man1"
mkdir -p "$MAN_DIR"
if [[ $QUIET == false ]]; then
  echo "📄 Updating man page…"
fi

local_man="${MAN_DIR}/webpCreate.1.new"
curl -fsSL "https://raw.githubusercontent.com/chachwick/webpCreate/main/man/webpCreate.1" \
  -o "$local_man"
chmod 644 "$local_man"
mv "$local_man" "${MAN_DIR}/webpCreate.1"

if [[ $QUIET == false ]]; then
  echo ""
  echo "✅ Update complete!"
  echo "👉 Run \`source ~/.zshrc\` if you haven’t already."
  echo "👉 Then try \`man webpCreate\` or \`webpCreate --help\`."
  echo "👉 If you need to update dependencies as well, run:"
  echo "   bash <(curl -fsSL https://raw.githubusercontent.com/chachwick/webpCreate/main/install-webpCreate.sh)"
fi
