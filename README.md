# RapidRAW: Creative Export — Borders & Grids 🖼️📐

[![License: AGPL v3](https://img.shields.io/badge/License-AGPL_v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)
[![macOS Support](https://img.shields.io/badge/macOS-Apple_Silicon-brightgreen.svg)]()
[![Windows Support](https://img.shields.io/badge/Windows-x64_NSIS-blue.svg)]()
[![Linux Support](https://img.shields.io/badge/Linux-AppImage_%7C_deb-orange.svg)]()
[![Auto-Release Workflow](https://github.com/puneetrane1811/rapidraw-creative-export-borders-and-grids/actions/workflows/auto-release.yml/badge.svg)](https://github.com/puneetrane1811/rapidraw-creative-export-borders-and-grids/actions/workflows/auto-release.yml)

A custom feature extension and automated CI/CD distribution pipeline for **[RapidRAW](https://github.com/CyberTimon/RapidRAW)**—the modern, high-performance open-source RAW photo editor built with Tauri, Rust, and React.

This project introduces native **Borders, Fine-Art Keylines, Multi-Photo Collages, Tile Splitters, and Real-Time Live Preview** directly into RapidRAW's UI and export pipeline, eliminating the need for external tools or fragmented post-processing scripts.

---

## Table of Contents

- [Motivation](#-motivation)
- [Features](#-features)
- [Downloads & Installation](#-downloads--installation)
  - [macOS (.dmg)](#macos-dmg)
  - [Windows (.exe)](#windows-exe)
  - [Linux (.AppImage / .deb)](#linux-appimage--deb)
- [How It Works (Code Architecture)](#-how-it-works-code-architecture)
- [Included Files](#-included-files)
- [Local Development & Building](#-local-development--building)
  - [Automated Local Script](#option-a-automated-local-rebuild)
  - [Manual Git Patch Workflow](#option-b-manual-git-patch-workflow)
- [Future Upstream Maintenance & Conflicts](#-future-upstream-maintenance--conflicts)
- [License & Acknowledgments](#-license--acknowledgments)

---

## 💡 Motivation

Modern photo publishing requires far more than basic raw development. Photographers regularly prepare images for diverse finishing formats:
- **Social Media & Portfolios**: Maintaining uniform aspect ratios without awkward cropping on platforms like Instagram, Behance, or VSCO.
- **Swipeable Panoramas & Mosaics**: Slicing wide landscapes or editorial shots into seamless multi-image carousels and $3 \times 3$ grid profile mosaics.
- **Client Contact Sheets & Collages**: Grouping series of photos into clean, structured $N \times M$ grids with precise gutters for client proofing or moodboards.
- **Museum & Gallery Prints**: Framing fine-art prints with outer mats and delicate, contrasting inner keylines (fillets) to separate the artwork from the mat.

### The Problem: Fragmented Workflows & Blind Processing
Previously, achieving these results required exporting files from RapidRAW and jumping between multiple external tools—Photoshop, Lightroom's Print module, mobile apps (Unfold, PanoraSplit), or tedious terminal scripts:

```bash
# Prior fragmented workarounds:
# 1. Adding borders
magick input.jpg -bordercolor white -border 2% framed.jpg

# 2. Assembling a 2x2 contact sheet collage
montage photo1.jpg photo2.jpg photo3.jpg photo4.jpg -tile 2x2 -geometry +20+20 collage.jpg

# 3. Slicing a panoramic swipe carousel
magick panorama.jpg -crop 3x1@ +repage tile_%d.jpg
```

This multi-step workflow created major pain points:
1. **Blind Trial-and-Error**: Shell scripts and external utilities provide no visual feedback until processing is done. Adjusting a margin or gutter required re-exporting and re-running commands repeatedly.
2. **Re-compression Quality Loss**: Exporting intermediate JPEGs and re-saving them through secondary tools causes unnecessary generation loss and degrades image fidelity.
3. **Broken Flow**: Photographers had to manage different third-party apps for borders, other apps for collage montages, and yet other tools for Instagram tile slicing.

### The Solution: Native Creative Export in RapidRAW
This extension integrates borders, fine-art keylines, multi-photo collages, multi-tile splitting, and composition grids directly into RapidRAW's core export engine:
- **Zero Generation Loss**: Borders, gutters, and slice matrices are rendered in a single high-performance pipeline directly from the developed 16-bit raster data.
- **Real-Time Visual Proofing**: An embedded, sticky HTML5 canvas renders live visual updates at 60fps as you adjust sliders, colors, and layouts.
- **One-Click Repeatability**: All configurations are remembered across export presets (`High Quality`, `Fast Web`, and custom presets).

---

## ✨ Features

- **🗂️ Dedicated Dual-Tab Workflow**: Clean separation between **Standard Export** (file formats, compression, sizing, destination, metadata) and **Creative Export** (hero live preview, framing mats, inset keylines, watermarks, multi-photo contact sheet collages, tile splitters, and proofing grids).
- **💾 Persistent Tab Memory**: Automatically remembers whether you were on Standard Export or Creative Export across launches and panel closures.
- **🚨 Active Feature Status Indicator**: Displays a clear accent status dot on the `Creative Export` tab whenever borders, keylines, watermarks, collages, or tile splitters are enabled, preventing accidental bordered or branded exports.
- **🖼️ Real-Time Sticky Live Export Preview**: Interactive canvas embedded directly in the Export Panel providing instant 60fps visual feedback for borders, keylines, watermarks, collage layouts, and tile slice lines as you adjust sliders, plus a full-screen darkroom inspection modal.
- **📷 EXIF Camera Badge & Technical Framing (Creative Export 2.0)**: Embed camera metadata, optical exposure parameters, and custom photographer signatures directly into the exported image or frame.
  - **Matte Bottom Strip ("Gallery Frame")**: Extends the canvas downward with an elegant matte strip featuring a clean 2-line layout—Camera, Lens, and Photographer Credit on the left, and Exposure Settings (ƒ-number, Shutter Speed, ISO, Focal Length) and Capture Date on the right.
  - **Floating Glass Pill ("Social Badge")**: Overlays a sleek, modern translucent pill in the bottom-right corner displaying exposure stats and camera badge.
  - **Granular Metadata Toggles**: Selectively enable or disable Camera Model, Lens Model, Exposure Details, and Capture Date.
  - **Photographer Signature / Credit**: Add custom watermark credit text (e.g. `Photo by Alex Morgan` or `© Studio`) alongside camera metadata.
  - **Customizable Palette**: Custom background color and text/accent color pickers for badge styling.
  - **Real-Time Canvas Proofing & Backend Rendering**: Rendered live at 60fps on the HTML5 preview canvas and baked into final full-resolution exports via embedded Truetype rasterization.
- **🏷️ Dynamic Filename Template System**: Robust, token-based output file naming available for both single and multi-image exports.
  - **Clickable Token Pills**: Insert tokens with a single click: `{original_filename}`, `{filename}`, `{date}`, `{camera}`, `{lens}`, `{iso}`, `{focal}`, `{aperture}`, `{shutter}`, `{sequence}`, `{seq}`, `{time}`, `{YYYY}`, `{MM}`, `{DD}`, `{hh}`, `{mm}`, `{ss}`.
  - **Quick One-Click Presets**: Fast preset buttons for common professional conventions (`Original + Edited`, `Date + Filename`, `Camera + ISO + Name`, `Sequence (01..)`).
  - **Live Sample Preview**: Instantly preview the resolved output filename dynamically beneath the template input field.
  - **Robust Backend Token Parser & Sanitizer**: Rust-level EXIF reader and sidecar parser in `file_management.rs` with automatic sanitization of illegal filesystem characters (`/`, `\`, `:`, `*`, `?`, `"`, `<`, `>`, `|`).
- **🔤 Real-Time Text & Image Watermarks**: High-resolution branding rendered in real time on the live preview canvas and baked seamlessly into final exports.
  - **Text Watermark (Default)**: Custom text input with adjustable scaling, text color picker, and subtle drop-shadow rendering for maximum legibility across any photograph.
  - **Image / Logo Watermark**: File picker supporting PNG, JPG, JPEG, and WebP logos with full transparency preservation.
  - **Interactive Drag & Custom Placement**: Position watermarks via 9 preset grid anchors, fine-tune normalized $X\% / Y\%$ coordinate sliders, or click and drag directly on the Live Preview canvas to position the watermark interactively.
  - **Precise Opacity Slider**: Smooth 1% to 100% alpha blending for subtle, professional proofing or prominent copyright marks.
  - **Zero-Dependency Font Engine**: Features an embedded compressed TrueType font (`DejaVuSans.ttf`) decompressed on the fly via `miniz_oxide` and rendered via `ab_glyph`, guaranteeing pixel-perfect text rendering across macOS, Windows, and Linux without relying on system fonts.
- **👁️ High-Contrast Accessible Controls**: All segmented buttons and toggles (Watermark Type, Placement Mode, Cell Sizing) strictly enforce high-contrast styling (`text-button-text` on `bg-accent`), ensuring clear, crisp readability across dark and light themes without washed-out text.
- **🛡️ Crash-Resilient Error Boundary**: Embedded React `<ErrorBoundary>` surrounds export panels to gracefully catch unexpected runtime anomalies and render an inline recovery card with a single-click "Retry" option, preventing transparent window unmounts.
- **📐 Multi-Photo Contact Sheet / Grid Collage**: Combine multiple selected photos into an $N \times M$ grid collage on a single canvas with customizable cell gutters (spacing) and outer border framing.
- **🔲 High-Contrast Fit vs. Fill Sizing Modes**: Choose between **Fit (Letterbox)** to preserve exact original photo aspect ratios without cropping, or **Fill (Center-Crop)** to fill each cell completely. Designed with high-contrast, accessible controls in both light and dark themes.
- **📱 Multi-Tile Grid Splitter (Instagram / Panorama)**: Slice any photo or collage into an $N \times M$ matrix of individual exported files with optional borders per tile—ideal for seamless swipeable Instagram carousels and $3 \times 3$ grid mosaics.
- **🎨 Fine-Art Inset Keyline**: Add museum-grade framing with a contrasting hairline inner border inset at any distance inside the outer mat.
- **📏 Composition Grid Overlay**: Overlay Rule of Thirds ($3 \times 3$) or custom $N \times M$ grid lines with adjustable opacity, thickness, and color for proofing and composition review.
- **🔢 Frictionless Numeric Editing**: Natural backspacing and direct typing in row and column inputs without forced snap-backs to 1, with automatic range clamping on blur.
- **🏷️ Smart Dynamic File Counts & Size Estimates**: Dynamically calculates and displays the exact output file count (e.g. `Export 1 Grid Photo` or `Export 9 Grid Tiles`) and accurate file size estimates for single-pass collages.
- **⚡ Fully Combinable**: Use any feature individually or combine them all together seamlessly in a single export run.
- **💾 Preset Persistence**: All border, keyline, watermark, collage, and tile split configurations are automatically remembered in default presets and custom user presets.

---

## 📦 Downloads & Installation

Pre-compiled, ready-to-install packages are available on the **[Releases](https://github.com/puneetrane1811/rapidraw-creative-export-borders-and-grids/releases)** page. **No programming tools or developer environments are needed.**

### macOS (.dmg)

1. Download `RapidRAW_<version>_aarch64.dmg` from [Releases](https://github.com/puneetrane1811/rapidraw-creative-export-borders-and-grids/releases).
2. Double-click the `.dmg` file and drag **RapidRAW** into your `/Applications` folder.
3. **First-launch Gatekeeper Bypass** (required for unsigned local builds):
   - **Finder**: Right-click (or <kbd>Control</kbd>-click) `RapidRAW.app` in `/Applications`, select **Open**, and click **Open** on the confirmation dialog.
   - **Or via Terminal**:
     ```bash
     xattr -cr /Applications/RapidRAW.app
     ```

### Windows (.exe)

1. Download `RapidRAW_<version>_x64-setup.exe` from [Releases](https://github.com/puneetrane1811/rapidraw-creative-export-borders-and-grids/releases) or the [Actions Artifacts](https://github.com/puneetrane1811/rapidraw-creative-export-borders-and-grids/actions).
2. Run the setup installer and follow the on-screen instructions.

### Linux (.AppImage & .deb)

Packages are available from [Releases](https://github.com/puneetrane1811/rapidraw-creative-export-borders-and-grids/releases):

- **Universal AppImage** (runs on Ubuntu, Fedora, Arch, Debian, openSUSE, etc.):
  ```bash
  chmod +x RapidRAW_*.AppImage
  ./RapidRAW_*.AppImage
  ```
- **Debian / Ubuntu Package (`.deb`)**:
  ```bash
  sudo dpkg -i RapidRAW_*.deb
  sudo apt-get install -f   # Resolves any missing system dependencies
  ```

---

## 🧠 How It Works (Code Architecture)

The feature is cleanly separated across the Rust backend and React frontend:

```
RapidRAW Source Tree
├── src-tauri/
│   ├── src/
│   │   ├── export_processing.rs   <-- Border math, keylines, collages, tile slicing, watermarks & EXIF badge rendering
│   │   ├── file_management.rs     <-- Dynamic filename template parser, EXIF token resolver & sanitizer
│   │   ├── default_font.rs        <-- Embedded compressed DejaVuSans font for OS-independent text rasterization
│   │   ├── app_settings.rs        <-- Preset schema, EXIF badge defaults & default preset values
│   │   └── lib.rs                 <-- Tauri command bindings & font module registration
├── src/
│   ├── components/
│   │   ├── panel/right/
│   │   │   ├── ExportPanel.tsx         <-- Tab orchestrator, session memory & export footer
│   │   │   ├── StandardExportTab.tsx   <-- File formats, sizing, dynamic filename template tokens
│   │   │   ├── CreativeExportTab.tsx   <-- Framing, keylines, watermarks, EXIF badge & collages
│   │   │   ├── ExportCommons.tsx       <-- Shared Section, GridNumberInput & helpers
│   │   │   └── ExportLivePreview.tsx   <-- Real-time HTML5 preview canvas, EXIF badges & inspector
│   │   └── ui/
│   │       ├── ExportImportProperties.tsx <-- TypeScript interface definitions
│   │       └── ErrorBoundary.tsx          <-- Defensive React error boundary for export panels
│   ├── hooks/
│   │   ├── useExportSettings.ts   <-- State management & preset synchronization
│   │   └── useExternalEditSession.ts <-- External session payload defaults
│   └── i18n/locales/
│       └── en.json                <-- Localization strings
```

### Technical Details

1. **Dimension Math (`export_processing.rs`)**:
   Calculates border padding as a percentage of the image dimensions with integer overflow safety:
   ```rust
   let horizontal = ((width as f32 * size / 100.0).round() as u32).max(1);
   let vertical   = ((height as f32 * size / 100.0).round() as u32).max(1);

   let output_width  = width.checked_add(horizontal.saturating_mul(2))?;
   let output_height = height.checked_add(vertical.saturating_mul(2))?;
   ```
2. **Buffer Allocation & Blending**:
   Allocates a new RGBA canvas sized `(output_width, output_height)` initialized to the chosen hex color, and overlays the processed image onto the center at `(horizontal, vertical)`.
3. **Resolution Metadata Preservation**:
   Updates `final_full_w` and `final_full_h` in `determine_export_dimensions` so exported sidecars and EXIF records match the final bordered canvas size.
4. **Watermark Engine & Font Pipeline (`default_font.rs` & `export_processing.rs`)**:
   - **Embedded TrueType Font**: Stores a compressed `DejaVuSans.ttf` byte array in `default_font.rs`. At runtime, `miniz_oxide::inflate::decompress_to_vec` decompresses it into memory for `ab_glyph::FontRef`.
   - **Text Rasterization**: Computes dynamic font scaling relative to image dimensions. Draws a subtle semi-transparent black drop-shadow offset by $(+2\text{px}, +2\text{px})$ before rendering the primary colored glyphs, ensuring crisp readability over any background.
   - **Image Watermarking**: Decodes user logos (PNG/JPG/WebP), resizes via bilinear interpolation to match target scale percentages, and composites onto 8-bit, 16-bit, and 32-bit float raster buffers with alpha and opacity weighting.
5. **High-Contrast Theming Contract**:
   To prevent washed-out text when options are toggled in dark mode (where `--app-accent` is pure white `#ffffff`), all active toggle states strictly pair `bg-accent` with `text-button-text font-semibold shadow-sm`. Inactive toggles cleanly use `text-text-secondary hover:text-text-primary`.
6. **Defensive UI Hardening (`ErrorBoundary.tsx`)**:
   RapidRAW uses a frameless, transparent webview configuration (`"transparent": true`, `"decorations": false`). Any unhandled React exception causes the root DOM to unmount, rendering the window invisible. Wrapping export tabs in `<ErrorBoundary>` intercepts exceptions and renders a recovery card with error diagnostic details and a "Try Again" reload button.
7. **EXIF Camera Badge & Technical Framing Engine (`export_processing.rs` & `ExportLivePreview.tsx`)**:
   - **Dual Layout Engines**: Renders either a bottom matte extension strip with a 2-line layout (Left: Camera / Lens / Signature; Right: Exposure ƒ/shutter/ISO/focal & Date) or an overlay floating pill with rounded corners and translucent background.
   - **Automated Metadata Extraction**: Extracts camera make/model, lens, ƒ-stop, shutter speed, ISO, focal length, and capture date from EXIF cache and sidecars, formatting clean strings with fallback fallbacks.
   - **Full-Resolution TrueType Blending**: Bakes crisp text directly into the final export raster at full sensor resolution using `ab_glyph` glyph rendering and anti-aliased font rasterization.
8. **Dynamic Filename Template Parser (`file_management.rs`)**:
   - **Token Resolution**: Parses tokens like `{original_filename}`, `{filename}`, `{camera}`, `{lens}`, `{iso}`, `{focal}`, `{aperture}`, `{shutter}`, `{date}`, `{time}`, `{seq}`, and calendar tokens `{YYYY}`, `{MM}`, `{DD}`, `{hh}`, `{mm}`, `{ss}`.
   - **Filesystem Sanitization**: Automatically strips or replaces illegal path and filename characters (`/`, `\`, `:`, `*`, `?`, `"`, `<`, `>`, `|`, control characters) to ensure exported files write safely across macOS APFS, Windows NTFS, and Linux ext4.

---

## 📂 Included Files

| File | Description |
| :--- | :--- |
| [`creative-export-borders-and-grids.patch`](./creative-export-borders-and-grids.patch) | Complete, clean unified diff patch against the RapidRAW codebase. |
| [`build-creative-export-borders-and-grids.sh`](./build-creative-export-borders-and-grids.sh) | Local shell script to download any RapidRAW version, apply the patch, and build a `.dmg`. |
| [`.github/workflows/auto-release.yml`](./.github/workflows/auto-release.yml) | Continuous cloud automation: monitors upstream, builds macOS, Windows, & Linux, and publishes releases. |
| [`.github/workflows/build-macos.yml`](./.github/workflows/build-macos.yml) | Dedicated workflow to compile native macOS `.dmg` installers on demand. |
| [`.github/workflows/build-windows.yml`](./.github/workflows/build-windows.yml) | Dedicated workflow to compile native Windows `.exe` installers on demand. |
| [`.github/workflows/build-linux.yml`](./.github/workflows/build-linux.yml) | Dedicated workflow to package Linux `.AppImage` and `.deb` installers on demand. |

---

## 💻 Local Development & Building

If you prefer building locally on your Mac:

### Option A: Automated Local Rebuild

Use the included helper script:
```bash
# Build against latest main branch:
./build-creative-export-borders-and-grids.sh

# Build against a specific tag (e.g. v1.7.0):
./build-creative-export-borders-and-grids.sh v1.7.0
```

### Option B: Manual Git Patch Workflow

1. **Clone RapidRAW**:
   ```bash
   git clone https://github.com/CyberTimon/RapidRAW.git
   cd RapidRAW
   ```

2. **Apply the patches**:
   - **Patch 1: Creative Export Engine (Core Borders, Grids, EXIF Badges & Filename Templates)**:
     ```bash
     git apply --ignore-whitespace /path/to/creative-export-borders-and-grids.patch
     ```
   - **Patch 2: Center Stage Export Studio (Full-stage darkroom workspace with bottom photo roll)**:
     ```bash
     git apply --ignore-whitespace /path/to/center-stage-creative-export-studio.patch
     ```

3. **Build the macOS DMG**:
   ```bash
   npm ci
   npm run tauri -- build --bundles dmg --no-sign
   ```

4. **Build the Windows EXE (on a Windows PC)**:
   ```bash
   npm ci
   npm run tauri -- build --bundles nsis
   ```

---

## ⚠️ Future Upstream Maintenance & Conflicts

Because this patch is small and modular (isolated strictly to export UI, preset storage, and export processing), it applies cleanly across versions.

If RapidRAW significantly refactors the export panel in a future release:
1. Run:
   ```bash
   git apply --reject creative-export-borders-and-grids.patch
   ```
2. Any conflicting hunks will be written to `.rej` files.
3. Review the `.rej` file and manually reposition the small UI block in `ExportPanel.tsx` or hook in `export_processing.rs`.

---

## 📄 License & Acknowledgments

- **RapidRAW** is created by [Timon Käch (CyberTimon)](https://github.com/CyberTimon) and licensed under the **[GNU Affero General Public License v3 (AGPL-3.0)](https://www.gnu.org/licenses/agpl-3.0)**.
- This patch and all workflows in this repository are distributed under the same **AGPL-3.0** license.
