# webpCreate
Get your images converted for fast load times! webpCreate scans a directory for JPG, JPEG, and PNG files, then converts them to web-ready WEBP images. Further, it organizes the files to keep your directories clean. 

webpCreate is a Zsh script for batch-converting `.jpg`, `.jpeg`, and `.png` files into `.webp` format with optional overwrite/increment/skip behavior. It organizes originals and `.webp` output into subfolders and reports file size savings.

I use it straight from my MacOS terminal window. First, I use "cd" to get to the directory with my images (often a big dump of images from a client, or a photoshop batcnh export). Then I type "webpCreate" and watch the magic happen.

## 🛠 Features

- Converts `.jpg`, `.jpeg`, `.png` (case-insensitive)
- Handles filename conflicts with user prompts:
  - (o)verwrite
  - (i)ncrement
  - (s)kip
- Moves original files to `JPG/` and `PNG/` folders
- Saves `.webp` files to `WEBP/`
- Summarizes file count, total size, and savings

## 🚀 Quick Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/chachwick/webpCreate/main/install-webpCreate.sh)
**
