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
