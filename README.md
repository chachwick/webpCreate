# webpCreate

**Batch WebP converter for macOS — resize, preserve EXIF, organize originals, and save serious disk space.**
*(BETA – but already working hard in the field)*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![macOS](https://img.shields.io/badge/OS-macOS%2010.15+-lightgrey.svg)](#)

------

## 🚀 Why webpCreate?

Tired of juggling a dozen image folders, slow load-times, resizing by hand, and worrying about losing EXIF orientation?
`webpCreate` is a **Zsh-powered batch converter** for **JPEG, PNG, and HEIC** that:

- Converts to **WebP** (optionally keeps JPEGs too)
- Preserves orientation and EXIF where it counts
- Organizes your originals in tidy subfolders
- Lets you fine-tune quality, resize on the fly, and run multi-threaded
- Gives you a **clear before/after size report**
- Includes **safe testing modes** and detailed **debug logging**

------

## 💡 Use Cases

- **Website optimization** — Slash image load times without manual resizing.
- **Archiving** — Shrink huge photo folders while preserving metadata.
- **Content pipelines** — Preprocess assets for blogs, e-commerce, or apps.
- **Mixed-format cleanup** — Consolidate JPEG, PNG, and HEIC into consistent WebP output.
- **Dual-format delivery** — Need both modern WebP *and* JPEG fallback? One command does both.
- **Dry runs for safety** — Preview changes without touching files.

------

## ✨ Features

- **Formats:** JPEG, PNG, HEIC → WebP (HEIC via `sips` or `ffmpeg`)
- **EXIF orientation**: auto-detect, warn only, or ignore
- **Organized output**: Originals moved to `JPG/`, `PNG/`, `HEIC/`; WebPs in `WEBP/`
- **Resizing**: cap longest side to any pixel value (`--maxd`)
- **Quality control**: lossy/lossless, compression tuning, arbitrary `cwebp` flags
- **Speed**: multi-threaded encoding, parallel directory processing
- **Conflict handling**: overwrite, increment, or skip — selectable via flags or prompts
- **Safety**: dry run mode to preview changes; debug mode for deep troubleshooting
- **Reports**: per-directory file counts, sizes, and savings %
- **Metadata**: embeds a “Created by webpCreate” comment (skip with `--no-meta`)

------

## 🛠 Installation

**Quick install:**

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/chachwick/webpCreate/main/install-webpCreate.sh)
```

What this does:

1. Updates Homebrew
2. Installs `webp` (cwebp), `ffmpeg`, `exiftool`
3. Downloads scripts into `~/scripts`
4. Installs the man page
5. Adds `~/scripts` to your PATH and `update-webpCreate` alias

**Dependencies:**

- macOS 10.15+
- Zsh shell
- [cwebp](https://developers.google.com/speed/webp/docs/cwebp)
  `brew install webp`
- [ffmpeg](https://ffmpeg.org/) *(optional, HEIC)*
- [exiftool](https://exiftool.org/) *(metadata handling)*
- `sips` *(built into macOS)*

------

## 📦 Usage

```bash
webpCreate [options] [dir1 dir2 ...]
```

- No args = current directory.
- Multiple dirs allowed; add `--parallel` to process them at the same time.

------

## ⚙ Options

| Flag                            | Description                                           |
| ------------------------------- | ----------------------------------------------------- |
| `-h`, `--help`                  | Show help and exit                                    |
| `-q`, `--quality Q`             | Set quality (0–100, default 80)                       |
| `--maxd N`                      | Resize longest side ≤ N px                            |
| `--lossless`                    | Use lossless compression                              |
| `--mt`                          | Multi-thread encoding                                 |
| `--cwoption OPT`                | Pass custom option to cwebp                           |
| `--parallel`, `-P`              | Process directories in parallel                       |
| `--jpeg`                        | Create JPEG copies too                                |
| `-o MODE`, `--orientation MODE` | Orientation: `detect` (default), `warn`, `ignore`     |
| `--no-meta`                     | Skip embedding creator metadata                       |
| `--dryrun`                      | Simulate conversions without making any file changes  |
| `--debug`                       | Enable verbose debug logging                          |
| `--overwrite`                   | Automatically overwrite conflicting files             |
| `--skip`                        | Automatically skip conflicting files                  |
| `--increment`                   | Automatically rename conflicting files with a counter |

------

## 🖼 Examples

```bash
# Current folder, defaults
webpCreate

# Two folders, quality 75, resize to 1200px
webpCreate -q 75 --maxd 1200 ~/Pictures ~/Downloads

# Lossless + multi-thread
webpCreate --lossless --mt ./images

# WebP + JPEG output, quality 85
webpCreate --jpeg -q 85 ./assets

# Ignore orientation metadata
webpCreate -o ignore ./photos

# Dry run (preview changes without touching files)
webpCreate --dryrun ./images

# Debug mode to troubleshoot
webpCreate --debug --jpeg ~/Pictures
```

------

## 📊 Orientation Modes

| Mode     | What it does                                  | Use it when…                                |
| -------- | --------------------------------------------- | ------------------------------------------- |
| `detect` | Auto-corrects orientation via EXIF & metadata | Most workflows                              |
| `warn`   | Shows orientation issues without fixing them  | Diagnostics                                 |
| `ignore` | Leaves pixels untouched                       | Special cases where rotation breaks content |

------

## 🛡 Safety & Testing

Before processing large batches:

1. **Test with `--dryrun`**
   This will list exactly what would happen — conversions, moves, overwrites — without touching any files.
2. **Use `--debug`** for deep inspection
   Prints full command lines, variable states, and internal decisions. Ideal for diagnosing unexpected results.

------

## 📜 Reference

```bash
man webpCreate
```

- [cwebp docs](https://developers.google.com/speed/webp/docs/cwebp)
- `man sips`

------

## 🤝 Contributing

PRs welcome! Add features, fix bugs, or help port to other shells.

------

## 📄 License

MIT © 2025 Chadwick Self
