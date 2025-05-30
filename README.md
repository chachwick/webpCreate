# webpCreate

A Zsh utility to batch-convert images to WebP for fast web delivery, while organizing originals and supporting optional resizing and advanced WebP options.

## 🔍 Why WebP?

WebP offers superior compression (both lossy and lossless) compared to JPEG and PNG, reducing file sizes and improving page-load performance without perceptible quality loss.

## 🚀 Features

* **HEIC support**: Converts `.heic/.HEIC` to JPEG and moves originals to `HEIC/`.
* **Batch conversion**: Processes `.jpg`, `.jpeg`, `.png` (case-insensitive).
* **Optional resizing**: Resize images so the longest side meets a maximum pixel dimension.
* **Custom WebP flags**: Pass any `cwebp` option (e.g. `-lossless`, `-q 75`, `-af`) via `--cwoption` or dedicated flags.
* **Conflict handling**: On filename collisions in `WEBP/`, choose to overwrite, increment, or skip.
* **Organized folders**: Moves originals into `HEIC/`, `JPG/`, and `PNG/` directories; outputs WebP to `WEBP/`.
* **Savings summary**: Reports counts, sizes before/after, total savings and percentage.
* **Self-update**: `--update` flag fetches latest script from GitHub.

## ⚙️ Dependencies

* [Homebrew](https://brew.sh/) (macOS package manager)
* `cwebp` (provided by `brew install webp`)
* `ffmpeg` (for HEIC support, optional; `brew install ffmpeg`)
* `sips` (built into macOS)

## 🛠 Installation

### 1. Bootstrap installer (recommended)

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/chachwick/webpCreate/main/install-webpCreate.sh)
```

This script:

1. Updates Homebrew
2. Installs/upgrades `webp` and `ffmpeg`
3. Downloads `webpCreate` to `~/scripts`
4. Makes it executable and adds `~/scripts` to your `PATH`

### 2. Manual install

```bash
brew update
brew install webp ffmpeg
mkdir -p "$HOME/scripts"
curl -fsSL https://raw.githubusercontent.com/chachwick/webpCreate/main/webpCreate \
  -o "$HOME/scripts/webpCreate"
chmod +x "$HOME/scripts/webpCreate"
echo 'export PATH="$HOME/scripts:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## 🎯 Usage

```bash
cd /path/to/images
webpCreate [options]
```

### Options

```text
-?, -h, --help           Show help and exit
--update                 Self-update script from GitHub and exit
--maxd <pixels>          Set max dimension for longest side (skip prompt)
--lossless               Add WebP lossless compression (-lossless)
--cwoption <opt>         Pass custom cwebp flag (e.g. "-q 75" or -af)
```

See `webpCreate -?` for examples and links to `cwebp` docs.

## 📂 Workflow Example

```bash
# Resize to 1200px max width/height and quality 75
git clone https://github.com/chachwick/webpCreate.git
cd ~/projects/webpCreate
bash install-webpCreate.sh
cd ~/Downloads/images
webpCreate --maxd 1200 --cwoption "-q 75"
```

## 📖 Documentation & Support

* GitHub repository: [https://github.com/chachwick/webpCreate](https://github.com/chachwick/webpCreate)
* `cwebp` manual: `man cwebp`
* WebP docs: [https://developers.google.com/speed/webp/docs/cwebp](https://developers.google.com/speed/webp/docs/cwebp)

---

*Created and maintained by chachwick.*
