```bash
#!/usr/bin/env bash
set -e

show_help() {
  cat <<-EOF
Usage: update-webpCreate [options]

Fetch the latest webpCreate, update-webpCreate, and man-page from GitHub,
and show version changes if any.

Options:
  -h, --help       Show this help and exit
  -v, --version    Print the currently installed webpCreate version and exit
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

# Helper: fetch remote version string
fetch_remote_version() {
  curl -fsSL https://raw.githubusercontent.com/chachwick/webpCreate/main/webpCreate \
    | grep -m1 '^# webpCreate version:' \
    | cut -d':' -f2 | xargs
}

# Helper: extract local version string (if exists)
local_version=""
if [[ -f "$HOME/scripts/webpCreate" ]]; then
  local_version=$(grep -m1 '^# webpCreate version:' "$HOME/scripts/webpCreate" \
    | cut -d':' -f2 | xargs)
fi

remote_version=$(fetch_remote_version)

# Show version info
if [[ $QUIET == false ]]; then
  echo "Local version:  $local_version"
  echo "Remote version: $remote_version"
fi

# Compare and exit if up to date
if [[ "$remote_version" == "$local_version" ]]; then
  if [[ $QUIET == false ]]; then
    echo "✅ webpCreate is already up to date (version $local_version)."
  fi
  exit 0
fi

# Download and replace helper
download_and_replace() {
  local url=$1 dst=$2 tmp
  tmp="$(mktemp "${dst}.XXXXXX")"
  curl -fsSL "$url" -o "$tmp"
  chmod +x "$tmp"
  mv "$tmp" "$dst"
}

# Ensure ~/scripts exists and is writable
mkdir -p "$HOME/scripts"
if [[ ! -w "$HOME/scripts" ]]; then
  echo "❌ Cannot write to $HOME/scripts. Check permissions." >&2
  exit 1
fi

if [[ $QUIET == false ]]; then
  echo "🔄 Updating webpCreate from $local_version → $remote_version…"
fi

download_and_replace \
  "https://raw.githubusercontent.com/chachwick/webpCreate/main/webpCreate" \
  "$HOME/scripts/webpCreate"

if [[ $QUIET == false ]]; then
  echo "🔄 Updating update-webpCreate…"
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

local_man="$(mktemp "${MAN_DIR}/webpCreate.XXXXXX")"
curl -fsSL "https://raw.githubusercontent.com/chachwick/webpCreate/main/man/webpCreate.1" \
  -o "$local_man"
chmod 644 "$local_man"
mv "$local_man" "${MAN_DIR}/webpCreate.1"

if [[ $QUIET == false ]]; then
  echo ""
  echo "✅ Updated to version $remote_version."
  echo "👉 Run \`source ~/.zshrc\` if you haven’t already."
  echo "👉 Then try \`man webpCreate\` or \`webpCreate --help\`."
  echo "👉 If you need to update dependencies as well, run:"
  echo "   bash <(curl -fsSL https://raw.githubusercontent.com/chachwick/webpCreate/main/install-webpCreate.sh)"
fi
```
