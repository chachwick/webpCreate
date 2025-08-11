# Test Images for Orientation Handling

This directory contains test images to verify the orientation handling functionality of webpCreate.

## Key Test Cases

### Images 9 and 10 - Orientation Issues
- **image 9.jpg**: Dimensions 4032×3024 (landscape pixels) but displays as portrait in macOS Preview
- **Image 10.jpg**: Dimensions 4032×3024 (landscape pixels) but displays as portrait in macOS Preview

These images demonstrate the common issue where:
- File pixel dimensions are landscape (width > height)
- macOS Preview/Finder displays them as portrait due to orientation metadata
- WebP conversion may not match the Preview appearance without proper handling

## Testing Different Orientation Modes

### Ignore Mode (preserve raw pixel data)
```bash
webpCreate --debug --dryrun -o ignore test_images/
```
- Should preserve the raw 4032×3024 dimensions
- Resulting WebP should match the actual pixel data (landscape)
- Uses `cwebp -metadata none` to strip orientation flags

### Detect Mode (match Preview display)
```bash
webpCreate --debug --dryrun -o detect test_images/
```
- Should detect orientation metadata and apply corrections
- Resulting WebP should match how the image appears in macOS Preview (portrait)
- Checks EXIF → macOS metadata → preserve as fallback

### Warn Mode (diagnostic information)
```bash
webpCreate --debug --dryrun -o warn test_images/
```
- Shows what orientation metadata is found
- Warns about potential mismatches
- Doesn't apply automatic corrections

## Expected Debug Output

When using `--debug`, you should see output like:
```
🐛   Checking orientation metadata for: image 9.jpg
🐛   sips orientation: <nil>
🐛   kMDItemOrientation: (null)
🐛   Rotation tag: (null)
🐛   No orientation metadata found
```

This indicates why these images are problematic - they have no explicit orientation metadata, yet macOS displays them rotated.