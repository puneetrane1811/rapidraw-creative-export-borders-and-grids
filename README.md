# RapidRAW: Center Stage Export Studio & Creative Export 🖼️📐

[![License: AGPL v3](https://img.shields.io/badge/License-AGPL_v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)
[![macOS Support](https://img.shields.io/badge/macOS-Apple_Silicon-brightgreen.svg)]()
[![Windows Support](https://img.shields.io/badge/Windows-x64_NSIS-blue.svg)]()
[![Linux Support](https://img.shields.io/badge/Linux-AppImage_%7C_deb-orange.svg)]()
[![Auto-Release Workflow](https://github.com/puneetrane1811/rapidraw-creative-export-borders-and-grids/actions/workflows/auto-release.yml/badge.svg)](https://github.com/puneetrane1811/rapidraw-creative-export-borders-and-grids/actions/workflows/auto-release.yml)

A feature extension and automated distribution pipeline for **[RapidRAW](https://github.com/CyberTimon/RapidRAW)**—the modern, high-performance open-source RAW photo editor built with Tauri, Rust, and React.

This project introduces **Center Stage Export Studio**: a dedicated, full-screen creative darkroom featuring **Interactive Zoom & Canvas Proofing**, an integrated **Bottom Filmroll Photo Roll** with robust multi-selection, **Fine-Art Framing & Mats**, **Contrasting Inset Keylines**, **Dynamic EXIF Camera Badges**, **Dynamic Filename Templates**, **Composition & Slicing Tools**, **Multi-Photo Collages**, and **Watermarking Engine** directly into RapidRAW's core rendering pipeline.

---

## 📖 Table of Contents

- [💡 Motivation](#-motivation)
- [✨ Key Features](#-key-features)
  - [Center Stage Export Studio](#1-center-stage-export-studio)
  - [Interactive Zoom & Viewport Pan](#2-interactive-zoom--viewport-pan)
  - [Bottom Filmroll Photo Roll & Multi-Select](#3-bottom-filmroll-photo-roll--multi-select)
  - [Separation of Standard vs. Creative Export](#4-separation-of-standard-vs-creative-export)
  - [Fine-Art Mats & Inset Keylines](#5-fine-art-mats--inset-keylines)
  - [EXIF Camera Badge & Technical Framing](#6-exif-camera-badge--technical-framing)
  - [Dynamic Filename Template Engine](#7-dynamic-filename-template-engine)
  - [Composition & Slicing Tools](#8-composition--slicing-tools)
  - [Multi-Photo Contact Sheet / Collages](#9-multi-photo-contact-sheet--collages)
  - [Text & Logo Watermarks](#10-text--logo-watermarks)
- [📦 Downloads & Installation](#-downloads--installation)
  - [macOS (.dmg)](#macos-dmg)
  - [Windows (.exe)](#windows-exe)
  - [Linux (.AppImage / .deb)](#linux-appimage--deb)
- [🧠 How It Works (Code Architecture)](#-how-it-works-code-architecture)
- [📂 Included Files](#-included-files)
- [💻 Local Development & Building](#-local-development--building)
  - [Option A: Automated Local Rebuild](#option-a-automated-local-rebuild)
  - [Option B: Manual Dual-Patch Workflow](#option-b-manual-dual-patch-workflow)
- [⌨️ Keyboard & Mouse Shortcuts](#️-keyboard--mouse-shortcuts)
- [⚠️ Upstream Maintenance & Conflicts](#️-upstream-maintenance--conflicts)
- [📄 License & Acknowledgments](#-license--acknowledgments)

---

## 💡 Motivation

Modern photo publishing requires far more than basic raw development. Photographers regularly prepare images for diverse finishing formats:
- **Social Media & Portfolios**: Maintaining uniform aspect ratios without awkward cropping on platforms like Instagram, Behance, or VSCO.
- **Swipeable Panoramas & Mosaics**: Slicing wide landscapes or editorial shots into seamless multi-image carousels and $3 \times 3$ grid profile mosaics.
- **Client Contact Sheets & Collages**: Grouping series of photos into clean, structured $N \times M$ grids with precise gutters for client proofing or moodboards.
- **Museum & Gallery Prints**: Framing fine-art prints with outer mats and delicate, contrasting inner keylines (fillets) to separate the artwork from the mat.
- **Technical Provenance & Branding**: Displaying camera, lens, optical exposure settings, and photographer signatures on client previews or social cards.

### The Problem: Cramped Sidebars & Blind External Processing
Previously, achieving these results required either juggling external tools (Photoshop, Lightroom Print, command-line ImageMagick scripts) or squinting at tiny sidebar thumbnail previews. This caused:
1. **Blind Trial-and-Error**: Shell scripts and small panels provide no visual feedback until processing is done. Adjusting a margin or gutter required re-exporting repeatedly.
2. **Re-compression Quality Loss**: Intermediate JPEGs saved through secondary tools degrade image fidelity.
3. **Broken Flow**: Photographers had to bounce constantly back and forth between Library and Export panels just to select images.

### The Solution: Native Center Stage Export Studio
This extension elevates export into a first-class creative workspace:
- **Full Viewport Stage**: A dedicated darkroom view with interactive canvas zoom and pan.
- **Built-in Film Roll**: Select, review, and multi-select photos directly inside the export module.
- **Zero Generation Loss**: Borders, gutters, and slice matrices are rendered in a single high-performance pipeline directly from the developed 16-bit raster data.
- **Real-Time Visual Proofing**: An embedded HTML5 canvas renders live visual updates at 60fps as you adjust sliders, colors, and layouts.

---

## ✨ Key Features

### 1. Center Stage Export Studio
- Dedicated full-window darkroom module (`activeView: 'export'`) accessible from the top navigation bar or via the sidebar banner.
- High-DPI canvas preview rendering at full resolution with responsive auto-scaling.
- Collapsible right-hand drawer organizing presets, framing, camera badges, composition tools, filename templates, and watermarks.

### 2. Interactive Zoom & Viewport Pan
- **Floating Darkroom Toolbar**: Seamlessly zoom in (`+`), zoom out (`-`), or reset (`Fit`) directly over the live preview.
- **Smooth Magnification Range**: Scale anywhere from `25%` (macro overview) up to `300%` (pixel-level inspection of keylines, watermarks, and EXIF typography).
- **Mouse & Trackpad Zooming**: Hold `Cmd` / `Ctrl` and use the mouse wheel or trackpad pinch to zoom smoothly.
- **Auto-Fitting Stage**: Intelligently recalculates fit boundaries whenever images or multi-photo batch selections change.

### 3. Bottom Filmroll Photo Roll & Multi-Select
- Persistent horizontal filmroll at the bottom of the Export Studio displaying all photos in the current library.
- **Seamless Single Click**: Inspect any photo and its EXIF data instantly without unwanted navigation redirects back to the Library.
- **`Cmd` / `Ctrl` + Click Multi-Select**: Toggle individual photos into batch selections with synchronized visual checkboxes.
- **`Shift` + Click Range Select**: Rapidly select contiguous series of photos.
- **Preserved State**: Active batch selections remain intact while switching between photos.

### 4. Separation of Standard vs. Creative Export
- **Sidebar (`ExportPanel.tsx`)**: Dedicated strictly to standard export (file format, JPEG/WebP/TIFF quality, color profiles, dimension limits, sharpening, destination folder).
- **Studio Launcher Banner**: Prominent card in the sidebar providing one-click access to the full Center Stage Export Studio.
- **Studio Drawer (`CreativeExportTab.tsx`)**: Dedicated strictly to creative finishing tools, framing, composition grids, multi-tile splitters, and dynamic badges.

### 5. Fine-Art Mats & Inset Keylines
- **Outer Mat Border**: Uniform border framing (0.5% to 50% of image dimensions) with full hex color customization.
- **Museum Inset Keyline (Fillet)**: Contrasting hairline inner border inset at any distance inside the outer mat with customizable stroke thickness and independent color picker.

### 6. EXIF Camera Badge & Technical Framing
- **Gallery Matte Strip**: Extends the canvas downward with an elegant 2-line bottom strip:
  - **Left**: Camera Make & Model, Lens, and Photographer Signature / Credit.
  - **Right**: Optical Exposure Settings (ƒ-number, Shutter Speed, ISO, Focal Length) and Capture Date.
  - **Centered Multi-Image Alignment**: Perfectly centered across single-photo or multi-photo collage frames.
- **Floating Glass Pill**: Sleek translucent overlay pill in the bottom-right corner.
- **Granular Toggles**: Selectively show/hide camera, lens, exposure, and date fields.

### 7. Dynamic Filename Template Engine
- Robust, token-based output file naming available for single-image and batch exports.
- **Clickable Token Pills**: `{original_filename}`, `{camera}`, `{lens}`, `{iso}`, `{focal}`, `{aperture}`, `{shutter}`, `{date}`, `{time}`, `{seq}`.
- **Live Resolved Preview**: Instantly preview the resolved output filename dynamically beneath the template input field.
- **Filesystem Sanitization**: Rust backend automatically sanitizes illegal filesystem characters (`/`, `\`, `:`, `*`, `?`, `"`, `<`, `>`, `|`).

### 8. Composition & Slicing Tools
- **Composition Grid Overlay**: Rule of Thirds ($3 \times 3$) or custom $N \times M$ grid lines with adjustable color, opacity, and line thickness.
- **Multi-Tile Grid Splitter**: Slices any image or collage into an $N \times M$ matrix of individual files—ideal for seamless swipeable Instagram carousels and $3 \times 3$ grid profile mosaics.

### 9. Multi-Photo Contact Sheet / Collages
- Combine multiple selected photos into an $N \times M$ grid collage on a single canvas.
- **Fit vs. Fill**: Choose between letterbox (preserve aspect ratio) or center-crop (uniform cells).
- Customizable cell gutters and outer border framing.

### 10. Text & Logo Watermarks
- **Embedded Font Pipeline**: Compressed `DejaVuSans.ttf` decompressed in memory via `miniz_oxide` and rendered via `ab_glyph`—zero operating system font dependencies.
- **High-Resolution Branding**: Custom text with automatic drop-shadow for legibility over any background, or PNG/JPG/WebP logo overlays.
- **Interactive Drag & Drop**: Click and drag directly on the preview canvas to position watermarks, or choose from 9 preset anchor points.

---

## 📦 Downloads & Installation

Pre-compiled, ready-to-install packages are available on the **[Releases](https://github.com/puneetrane1811/rapidraw-creative-export-borders-and-grids/releases)** page.

### macOS (.dmg)
1. Download `RapidRAW_1.6.4_aarch64.dmg` from [Releases](https://github.com/puneetrane1811/rapidraw-creative-export-borders-and-grids/releases).
2. Double-click the `.dmg` file and drag **RapidRAW** into your `/Applications` folder.
3. **First-launch Gatekeeper Bypass** (required for unsigned local builds):
   - **Finder**: Right-click (or <kbd>Control</kbd>-click) `RapidRAW.app` in `/Applications`, select **Open**, and click **Open** on the confirmation dialog.
   - **Or via Terminal**:
     ```bash
     xattr -cr /Applications/RapidRAW.app
     ```

### Windows (.exe)
1. Download `RapidRAW_<version>_x64-setup.exe` from [Releases](https://github.com/puneetrane1811/rapidraw-creative-export-borders-and-grids/releases).
2. Run the setup installer and follow the on-screen instructions.

### Linux (.AppImage / .deb)
1. Download the `.AppImage` or `.deb` package from [Releases](https://github.com/puneetrane1811/rapidraw-creative-export-borders-and-grids/releases).
2. For AppImage:
   ```bash
   chmod +x RapidRAW_*.AppImage
   ./RapidRAW_*.AppImage
   ```

---

## 🧠 How It Works (Code Architecture)

```
RapidRAW Source Tree
├── src-tauri/
│   ├── src/
│   │   ├── export_processing.rs   <-- Border math, keylines, collages, tile slicing, EXIF badges & watermarks
│   │   ├── file_management.rs     <-- Dynamic filename template parser, EXIF token resolver & sanitizer
│   │   ├── default_font.rs        <-- Embedded compressed DejaVuSans font for OS-independent text rasterization
│   │   ├── app_settings.rs        <-- Preset schema, EXIF badge defaults & default preset values
│   │   └── lib.rs                 <-- Tauri command bindings & font module registration
├── src/
│   ├── components/
│   │   ├── views/
│   │   │   └── ExportView.tsx         <-- Center Stage Studio: stage, zoom bar, film roll, drawer
│   │   ├── panel/right/
│   │   │   ├── ExportPanel.tsx        <-- Sidebar Standard Export + "Launch Export Studio" banner
│   │   │   ├── StandardExportTab.tsx  <-- File formats, sizing, dynamic filename template tokens
│   │   │   ├── CreativeExportTab.tsx  <-- Mats, keylines, EXIF badges, collages, watermarks
│   │   │   ├── ExportCommons.tsx      <-- Shared Section accordions, GridNumberInput & helpers
│   │   │   └── ExportLivePreview.tsx  <-- Real-time HTML5 preview canvas, zoom engine & pan viewport
│   │   └── ui/
│   │       ├── ExportImportProperties.tsx <-- Complete TypeScript interface definitions
│   │       └── ErrorBoundary.tsx          <-- Defensive React error boundary for export panels
│   ├── hooks/
│   │   ├── useAppNavigation.ts   <-- Navigation router with openInEditor guard
│   │   ├── useExportSettings.ts  <-- Export state management & preset synchronization
│   │   └── useLibraryStore.ts    <-- Image list and multiSelectedPaths store
│   └── i18n/locales/
│       └── en.json                <-- Localization strings
```

---

## 📂 Included Files

| File | Description |
| :--- | :--- |
| [`RapidRAW_1.6.4_aarch64.dmg`](./RapidRAW_1.6.4_aarch64.dmg) | Production Apple Silicon macOS installer with full Center Stage Export Studio. |
| [`center-stage-creative-export-studio.patch`](./center-stage-creative-export-studio.patch) | **Patch 2**: Center Stage Export Studio, interactive zoom toolbar, bottom filmroll multi-select, and isolated sidebar. |
| [`creative-export-borders-and-grids.patch`](./creative-export-borders-and-grids.patch) | **Patch 1**: Core Creative Export engine (Rust backend, EXIF badges, templates, borders, watermarks). |
| [`docs/EXPORT_STUDIO_GUIDE.md`](./docs/EXPORT_STUDIO_GUIDE.md) | Comprehensive user manual, architecture guide, and token reference. |
| [`build-creative-export-borders-and-grids.sh`](./build-creative-export-borders-and-grids.sh) | Automated local build script that applies patches and builds macOS DMG. |
| [`update-and-build.sh`](./update-and-build.sh) | Convenience wrapper for updating upstream and building the DMG. |
| [`.github/workflows/auto-release.yml`](./.github/workflows/auto-release.yml) | Continuous cloud automation: monitors upstream, builds macOS, Windows & Linux, and publishes releases. |
| [`.github/workflows/build-macos.yml`](./.github/workflows/build-macos.yml) | On-demand macOS compilation workflow. |
| [`.github/workflows/build-windows.yml`](./.github/workflows/build-windows.yml) | On-demand Windows compilation workflow. |
| [`.github/workflows/build-linux.yml`](./.github/workflows/build-linux.yml) | On-demand Linux compilation workflow. |

---

## 💻 Local Development & Building

### Option A: Automated Local Rebuild
```bash
# Build against latest main branch:
./build-creative-export-borders-and-grids.sh

# Build against a specific tag (e.g. v1.6.4):
./build-creative-export-borders-and-grids.sh v1.6.4
```

### Option B: Manual Dual-Patch Workflow
```bash
# 1. Clone RapidRAW
git clone https://github.com/CyberTimon/RapidRAW.git
cd RapidRAW

# 2. Apply Patch 1: Baseline Creative Export Engine
git apply --ignore-whitespace /path/to/creative-export-borders-and-grids.patch

# 3. Apply Patch 2: Center Stage Export Studio
git apply --ignore-whitespace /path/to/center-stage-creative-export-studio.patch

# 4. Install dependencies and compile
npm ci
npm run tauri -- build --bundles dmg --no-sign
```

---

## ⌨️ Keyboard & Mouse Shortcuts

| Shortcut / Gesture | Location | Action |
| :--- | :--- | :--- |
| `Cmd` / `Ctrl` + Click | Bottom Filmroll | Toggle photo in multi-selection |
| `Shift` + Click | Bottom Filmroll | Select contiguous range of photos |
| Click | Bottom Filmroll | Select and preview photo |
| `Cmd` / `Ctrl` + Mouse Wheel | Preview Stage | Smooth Zoom In / Zoom Out |
| Click `↺ Fit` | Zoom Toolbar | Reset zoom to fit screen |
| Click `+` / `-` | Zoom Toolbar | Increment / decrement zoom by 10% |
| Click & Drag | Canvas Preview | Reposition watermark interactively |

---

## ⚠️ Upstream Maintenance & Conflicts

Because this extension is architected as two modular patches:
1. **Patch 1 (`creative-export-borders-and-grids.patch`)** focuses strictly on the export backend math, EXIF parsing, and baseline components.
2. **Patch 2 (`center-stage-creative-export-studio.patch`)** focuses on the center-stage workspace, filmroll integration, and zoom toolbar.

If upstream RapidRAW modifies surrounding navigation or export files in future versions:
```bash
git apply --reject creative-export-borders-and-grids.patch
git apply --reject center-stage-creative-export-studio.patch
```
Inspect any `.rej` files and apply the small contextual changes manually.

---

## 📄 License & Acknowledgments

- **RapidRAW** is created by [Timon Käch (CyberTimon)](https://github.com/CyberTimon) and licensed under the **[GNU Affero General Public License v3 (AGPL-3.0)](https://www.gnu.org/licenses/agpl-3.0)**.
- This extension and all associated scripts and workflows are distributed under the same **AGPL-3.0** license.
