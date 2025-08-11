# webpCreate

**BETA VERSION** - Batch-convert images to WebP with organization, optional resizing, EXIF preservation, multi-threading, parallel directories, conflict handling, and a clear savings report. Optionally create JPEG copies alongside WebP files.

---

## 📖 Overview

`webpCreate` is a Zsh script that automates your image-optimization workflow:

1. **Converts** JPEG, PNG (case-insensitive) and HEIC (via macOS's `sips`) to WebP using Google's `cwebp`.  
2. **Preserves** EXIF orientation data to maintain proper portrait/landscape orientation.  
3. **Organizes** originals into `JPG/`, `PNG/`, or `HEIC/` **only if matching files exist**, and places all WebP outputs into `WEBP/`.  
4. **Optionally creates** JPEG copies with same dimensions and quality settings alongside WebP files.  
5. **Handles** name conflicts (overwrite, increment, skip).  
6. **Optionally resizes** so the longest side ≤ a max dimension you choose.  
7. **Supports**:
   - Quality tuning (`-q`/`--quality`)  
   - Lossless mode (`--lossless`)  
   - Multi-threading (`--mt`)  
   - Arbitrary `cwebp` flags (`--cwoption`)  
   - Parallel directory processing (`--parallel`/`-P`)  
   - Dual-format output (`--jpeg`)  
   - Flexible orientation handling (`-o detect/warn/ignore`)  
8. **Reports** per-directory file counts, sizes, total savings and percentage reduction.

---

## 🖥️ What You’ll See During Conversion

Rather than verbose `cwebp` statistics, each converted file prints a single line showing its filename and size reduction. For example:
```
▶ Image (32).jpg: 2.45 MB → 0.85 MB
▶ photo01.PNG: 3.10 MB → 0.65 MB
```
You’ll then get a final summary per directory, e.g.:
```
• Directory: ~/Pictures
- Images processed: 8
- Original total size: 25.60 MB
- WebP total size: 5.12 MB
- Savings: 20.48 MB (80% reduction)
```
---

## 🛠️ Dependencies

Ensure you have:

- **macOS** (10.15 or later)  
- **Zsh** (relies on Zsh globbing and `read -q`)  
- **Homebrew** for installing the rest:
  `
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

The installation script (see below will use Homebrew to install the following tools)

- **cwebp** (from the `webp` package)
  - Docs: https://developers.google.com/speed/webp/docs/cwebp
  - Install: `brew install webp`
- **ffmpeg** (optional, for HEIC→WebP via `ffmpeg`)
  - Docs: https://ffmpeg.org/
  - Install: `brew install ffmpeg`
- **sips** (built into macOS) for HEIC→JPEG conversion: `man sips`

------

## 🚀 Installation

Run the one-liner to install dependencies, scripts, man-page, and shell setup:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/chachwick/webpCreate/main/install-webpCreate.sh)
```

This will:

1. `brew update`
2. Install or upgrade `webp` (for `cwebp`) and `ffmpeg`
3. Download `webpCreate` and `update-webpCreate` into `~/scripts`
4. Install the `webpCreate.1` man-page under `$(brew --prefix)/share/man/man1`
5. Make them executable, add `~/scripts` to your `PATH`, and define the `update-webpCreate` alias in your `~/.zshrc`

After installation:

```bash
source ~/.zshrc
```

------

## 🔄 Updating

To pull down the latest scripts and man-page:

```bash
update-webpCreate
```

No need to re-run the full installer unless you want to refresh dependencies.

------

## 📂 Usage

```bash
webpCreate [options] [dir1 dir2 ...]
```

- **Default**: if no directories are given, processes the **current** working directory.
- You can list multiple directories; with `--parallel`, they’ll run concurrently.

------

## ⚙️ Options

| Flag                    | Description                                                  |
| ----------------------- | ------------------------------------------------------------ |
| `-h`, `--help`          | Show brief help and exit                                     |
| `-q`, `--quality Q`     | Set `cwebp` quality (0–100; default 80)                      |
| `--maxd N`              | Resize longest side to ≤ N px (non-interactive)              |
| `--lossless`            | Use `cwebp -lossless` for lossless compression               |
| `--mt`, `--multithread` | Enable `cwebp -mt` multi-threaded encoding                   |
| `--cwoption OPT`        | Pass arbitrary `OPT` (e.g. `-af`, `-z 9`) directly to `cwebp` |
| `--parallel`, `-P`      | Process multiple directories **in parallel**                 |
| `--jpeg`                | Also create JPEG copies with same dimensions/quality         |
| `-o`, `--orientation`   | Orientation handling: `detect` (default), `warn`, `ignore`   |

> **Resize Prompt**
> If you don’t supply `--maxd`, the script will ask:
>
> ```
> Would you like to resize images so their longest side is capped? [y/N]
> ```
>
> Enter a pixel value (e.g. `1200`) to enable resizing.

------

## 🔄 Orientation Handling

`webpCreate` provides three modes to handle image orientation and rotation:

### Orientation Modes

| Mode       | Description                                                   | Use Case                                    |
|------------|---------------------------------------------------------------|---------------------------------------------|
| `detect`   | **Default**. Enhanced metadata detection from EXIF, macOS metadata, and exiftool | Most images, automatic orientation correction |
| `warn`     | Show warnings about orientation issues but don't auto-correct | Diagnostic mode, understand potential issues |
| `ignore`   | Preserve exact image data, no orientation processing          | Images that should never be rotated        |

### Common Scenarios

**Images appear rotated in WebP but not JPEG?**
```bash
# Use ignore mode to preserve exact image data
webpCreate -o ignore --jpeg ~/Photos
```

**Want to see what orientation issues exist?**
```bash
# Use warn mode to get diagnostic information
webpCreate -o warn ~/Photos
```

**Trust the script to handle orientation automatically?**
```bash
# Use detect mode (default) - no flag needed
webpCreate --jpeg ~/Photos
```

### Technical Details

- **detect mode**: Checks EXIF orientation, macOS `kMDItemOrientation`, and exiftool data
- **Preview vs File Dimensions**: Some images display as portrait in Preview but have landscape file dimensions
- **Metadata Priority**: EXIF → macOS metadata → exiftool → dimension analysis
- **Conservative Approach**: Only applies orientation correction when confident

------

## 🔗 Reference

- **Full manual**:

  ```bash
  man webpCreate
  ```

- **cwebp documentation**: https://developers.google.com/speed/webp/docs/cwebp

- **sips manual**: `man sips`

------

## 📦 Examples

```bash
# Process current folder with defaults
webpCreate

# Process two folders, quality=75, max side 1200px
webpCreate -q 75 --maxd 1200 ~/Pictures ~/Downloads

# Parallel, lossless, multi-threaded on three dirs
webpCreate --parallel --lossless --mt dirA dirB dirC

# Pass a custom cwebp filter option
webpCreate --cwoption "-af" ./images

# Create both WebP and JPEG copies, quality 85, max 1600px
webpCreate --jpeg -q 85 --maxd 1600 ~/Photos

# Preserve exact image orientation (no rotation)
webpCreate -o ignore --jpeg --maxd 1600 ~/Photos

# Show orientation warnings but don't auto-correct
webpCreate -o warn ~/Photos
```

------

## 🤝 Contributing

Contributions, issues, and pull requests are welcome!
Feel free to improve the scripts, add ports for other shells, or suggest new features.

Repo: https://github.com/chachwick/webpCreate

------

## 📄 License

MIT © 2025 Chadwick Self
