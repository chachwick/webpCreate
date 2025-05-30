# webpCreate

**Batch-convert images to WebP** with organization, optional resizing, multi-threading, parallel directories, conflict handling, and a clear savings report. The script relies on cwebp 

---

## 📦 What It Does

1. **Converts** `.jpg`/`.jpeg`/`.png` (case-insensitive) and HEIC → JPEG (via `sips`)  
2. **Organizes** originals into `JPG/`, `PNG/`, `HEIC/` and outputs into `WEBP/`  
3. **Handles filename conflicts** (overwrite, increment, or skip)  
4. **Optionally resizes** so the longest side ≤ a max dimension you choose  
5. **Supports**:
   - Intra-file multi-threading (`-mt`)  
   - Custom `cwebp` flags (`--cwoption`)  
   - Parallel directory processing (`--parallel`)  
6. **Reports** per-directory counts, sizes, total savings, and percentage reduction  

---

## 🌐 Why WebP?

WebP delivers **smaller file sizes** and **faster page loads** while preserving quality. It’s supported by all modern browsers. `webpCreate` automates the end-to-end workflow so you can:

- Reduce bandwidth and storage  
- Speed up your websites  
- Track exactly how much space you save  

---

## 🚀 Installation

### Prerequisites

- **macOS** (with built-in `sips`)  
- **[Homebrew](https://brew.sh/)** for dependencies
- **Shell:** This script is optimized for Zsh (macOS default) The script uses Zsh-only features (like setopt null_glob, array slicing, and read -q)
Running under Bash might be done easily enough, and if you'd like to contribute to the script, the bash script could be placed in the repo. Ditto other shells if required. Fish users will need a separate rewrite.

### One-Line Bootstrap

This will install or upgrade everything and configure your shell:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/chachwick/webpCreate/main/install-webpCreate.sh)
