# webpCreate

Batch-convert images to WebP with organization, optional resizing, multi-threading, parallel directories, conflict handling, and a clear savings report.

---

## 📖 Overview

`webpCreate` is a Zsh script that automates your image-optimization workflow:

1. **Converts** JPEG, PNG (case-insensitive) and HEIC (via macOS’s `sips`) to WebP using Google’s `cwebp`.  
2. **Organizes** originals into `JPG/`, `PNG/`, `HEIC/` and outputs into `WEBP/`.  
3. **Handles** name conflicts (overwrite, increment, skip).  
4. **Optionally resizes** so the longest side ≤ a max dimension you choose.  
5. **Supports**:  
   - Quality tuning (`-q`/`--quality`)  
   - Lossless mode (`--lossless`)  
   - Multi-threading (`--mt`)  
   - Arbitrary `cwebp` flags (`--cwoption`)  
   - Parallel directory processing (`--parallel`/`-P`)  
6. **Reports** per-directory file counts, sizes, total savings and percentage reduction.

---

## 🛠️ Dependencies

Ensure you have:

- **macOS** (10.15 or later)  

- **Zsh** (relies on Zsh globbing and `read -q`)  

- **Homebrew** for installing the rest:

  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

```
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

> **Resize Prompt**
> If you don’t supply `--maxd`, the script will ask:
>
> ```
> Would you like to resize images so their longest side is capped? [y/N]
> ```
>
> Enter a pixel value (e.g. `1200`) to enable resizing.

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
```

------

## 🤝 Contributing

Contributions, issues, and pull requests are welcome!
Feel free to improve the scripts, add ports for other shells, or suggest new features.

Repo: https://github.com/chachwick/webpCreate

------

## 📄 License

MIT © 2025 Chadwick Self
