# RapidRAW: Center Stage Creative Export Studio 🖼️📐

[![License: AGPL v3](https://img.shields.io/badge/License-AGPL_v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)
[![macOS Support](https://img.shields.io/badge/macOS-Apple_Silicon-brightgreen.svg)]()
[![Windows Support](https://img.shields.io/badge/Windows-x64_NSIS-blue.svg)]()
[![Linux Support](https://img.shields.io/badge/Linux-AppImage_%7C_deb-orange.svg)]()
[![Auto-Release Workflow](https://github.com/puneetrane1811/rapidraw-creative-export-borders-and-grids/actions/workflows/auto-release.yml/badge.svg)](https://github.com/puneetrane1811/rapidraw-creative-export-borders-and-grids/actions/workflows/auto-release.yml)

A feature extension and automated distribution pipeline for **[RapidRAW](https://github.com/CyberTimon/RapidRAW)**—the modern, high-performance open-source RAW photo editor built with Tauri, Rust, and React.

This project introduces **Creative Export Studio**: seamlessly integrated directly into RapidRAW's existing Image Editor with **Single-Canvas 60fps Real-Time Proofing**, **Synchronous Pan & Zoom**, **Proof Export Frame (`F`)**, **Per-Image Retention & Granular Reverts**, **One-Click Presets & Batch Application**, **Fine-Art Framing & Polaroid Mats**, **Contrasting Inset Keylines**, **Dynamic EXIF Badges**, **Dynamic Filename Templates**, **Multi-Photo Grid Collages**, **Multi-Tile Splitters**, and **Composition Overlays**.

---

## 📖 Table of Contents

- [💡 Motivation & Evolution](#-motivation--evolution)
- [✨ Key Features](#-key-features)
  - [1. Single-Canvas Live Proofing Engine](#1-single-canvas-live-proofing-engine)
  - [2. Dedicated Creative Export Studio Tab](#2-dedicated-creative-export-studio-tab)
  - [3. Per-Image Creative Settings Retention](#3-per-image-creative-settings-retention)
  - [4. Granular Individual Reverts](#4-granular-individual-reverts)
  - [5. One-Click Presets & Batch Application](#5-one-click-presets--batch-application)
  - [6. Fine-Art Mats, Polaroids & Inset Keylines](#6-fine-art-mats-polaroids--inset-keylines)
  - [7. EXIF Camera Badge & Technical Framing](#7-exif-camera-badge--technical-framing)
  - [8. Standard Export, Collages & Splitters](#8-standard-export-collages--splitters)
  - [9. Dynamic Filename Template Engine](#9-dynamic-filename-template-engine)
  - [10. Text & Logo Watermarks](#10-text--logo-watermarks)
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

## 💡 Motivation & Evolution

Modern photo publishing requires far more than basic raw development. Photographers regularly prepare images for diverse finishing formats:
- **Social Media & Portfolios**: Maintaining uniform aspect ratios without awkward cropping on platforms like Instagram, Behance, or VSCO.
- **Swipeable Panoramas & Mosaics**: Slicing wide landscapes or editorial shots into seamless multi-image carousels and $3 \times 3$ grid profile mosaics.
- **Client Contact Sheets & Collages**: Grouping series of photos into clean, structured $N \times M$ grids with precise gutters for client proofing or moodboards.
- **Museum & Gallery Prints**: Framing fine-art prints with outer mats and delicate, contrasting inner keylines (fillets) to separate the artwork from the mat.
- **Technical Provenance & Branding**: Displaying camera, lens, optical exposure settings, and photographer signatures on client previews or social cards.

### The Evolution: Eliminating Duplicate Viewports & Redundant Canvases
In initial prototypes, export was separated into an isolated full-screen view (`activeView: 'export'`). However, maintaining a second canvas caused noticeable disadvantages:
1. **Redundant Memory & Rendering Overhead**: Recreating a second WebGL/HTML5 canvas duplicated image buffer memory and caused laggy handoffs between editing and exporting.
2. **Context Switching & Viewport Disruption**: Navigating between library, editor, and export forced users out of their primary editing headspace. Selecting images in a separate view caused confusing redirects.
3. **State Desynchronization**: Parameters adjusted in sidebars drifted out of sync with preview windows.

### The Solution: Direct Editor Integration with Single-Canvas Architecture
By refactoring the Creative Export Studio directly into the core **Image Editor (`EditorView.tsx`)**:
- **Single Source of Truth**: The active developed image is rendered once by the editor's high-performance pipeline. The new `<CreativeExportOverlay />` mounts directly over the canvas within `TransformComponent`, panning and zooming with 100% hardware-accelerated precision.
- **Instant Proofing Toggle (`F`)**: A dedicated sparkles toolbar icon and the `F` keyboard shortcut allow you to toggle the creative export frame on/off in real time without leaving your editing flow.
- **Per-Image Retention**: Just like exposure and white balance edits, creative framing and metadata configurations are retained independently per photo in persistent storage.
- **Presets & Batch Application**: Reusable presets allow one-click styling and instant batch-application across all selected photos in the filmstrip.

---

## ✨ Key Features

### 1. Single-Canvas Live Proofing Engine
- Eliminates duplicate canvases. The creative framing layer (`CreativeExportOverlay.tsx`) is rendered directly inside the editor viewport (`ImageCanvas.tsx`).
- Butter-smooth 60fps updates as sliders, colors, and font styles are adjusted.
- Full synchrony with pan, trackpad pinch, and mouse wheel zoom.
- Toggle proofing on and off instantly with the **Proof Export Frame (`F`)** button on the editor toolbar.

### 2. Dedicated Creative Export Studio Tab
- Integrated directly into the right-hand panel switcher: `Adjust` $\to$ `Crop` $\to$ `Masks` $\to$ `Inpaint` $\to$ `Presets` $\to$ `Export Studio` $\to$ `Export`.
- Clean, focused workflow: refine RAW adjustments, switch to `Export Studio` to frame and style, and click `Proceed to Export →` to render final files.

### 3. Per-Image Creative Settings Retention
- Just like RAW tone adjustments, creative framing and metadata badge settings are preserved on a per-photo basis via `useExportStore` (persisted to `localStorage` under `rapidraw_creative_settings_by_path`).
- Switching between photos in the bottom filmstrip automatically restores that specific image's creative settings.

### 4. Granular Individual Reverts
- Every creative section (Framing, Polaroid, Inset Keyline, Watermark, EXIF Badge) features an independent **Reset (`RotateCcw`)** button to revert individual modifications back to defaults without losing other tweaks.
- A master **Reset All Creative Filters** button allows a complete reset when starting fresh.

### 5. One-Click Presets & Batch Application
- **Built-in Presets**:
  - *Fine-Art Gallery Mat*: Classic exhibition white mat with balanced margins.
  - *Museum Dark Framing*: Archival charcoal border with an inset hairline keyline.
  - *Classic Polaroid 600*: Instant-film aesthetic with an elongated bottom chin.
  - *Technical Exposure Strip*: Full camera metadata, lens info, and optical exposure strip.
  - *Minimalist Social Pill*: Floating glass overlay pill in the bottom-right corner.
- **Custom User Presets**: Save custom configurations with custom names.
- **Batch Application**: Click **Apply to All Selected Photos** to push your active creative framing across every photo selected in the filmstrip with a single click.

### 6. Fine-Art Mats, Polaroids & Inset Keylines
- **Outer Mat Border**: Uniform border framing (0.5% to 50% of image dimensions) with full hex color customization.
- **Polaroid Format**: Elongated bottom chin multiplier ($1.0\times$ to $5.0\times$) recreating vintage instant film.
- **Museum Inset Keyline (Fillet)**: Contrasting hairline inner border inset at any distance inside the outer mat with customizable stroke thickness (1px to 10px) and independent color picker.

### 7. EXIF Camera Badge & Technical Framing
- **Gallery Matte Strip**: Extends the canvas downward with an elegant 2-line bottom strip:
  - **Left**: Camera Make & Model, Lens, and Photographer Signature / Credit.
  - **Right**: Optical Exposure Settings (ƒ-number, Shutter Speed, ISO, Focal Length) and Capture Date.
  - **Centered Alignment**: Dynamically centered across single or multi-photo layouts.
- **Floating Glass Pill**: Sleek translucent overlay pill in the bottom-right corner.
- **Granular Toggles**: Selectively show/hide camera, lens, exposure, and date fields.

### 8. Standard Export, Collages & Splitters
- Available under the **Export** tab:
  - **File Formats**: JPEG, PNG, TIFF, WebP with custom quality and bit depth.
  - **Grid Export (Collages)**: Multi-photo $N \times M$ contact sheet / grid collages with configurable gutters and cell fit mode (*Fit* vs. *Fill*).
  - **Multi-Tile Grid Splitter**: Slices photos into $N \times M$ seamless individual tiles for Instagram carousels and $3 \times 3$ grid profile mosaics.
  - **Composition Grid Overlays**: Rule of Thirds ($3 \times 3$) or custom grids with color and opacity controls.

### 9. Dynamic Filename Template Engine
- Robust token-based output file naming for single and batch exports:
  - `{original_filename}`, `{camera}`, `{lens}`, `{iso}`, `{focal}`, `{aperture}`, `{shutter}`, `{date}`, `{time}`, `{seq}`.
- **Live Resolved Preview**: Dynamically previews the generated filename under the template input.
- **Filesystem Sanitization**: Automatically cleans illegal characters (`/`, `\`, `:`, `*`, `?`, `"`, `<`, `>`, `|`).

### 10. Text & Logo Watermarks
- **Embedded Font Pipeline**: Compressed `DejaVuSans.ttf` decompressed in memory via `miniz_oxide` and rendered via `ab_glyph`—zero OS font dependencies.
- **High-Resolution Branding**: Custom text with automatic drop-shadow for legibility over any background, or PNG/JPG/WebP logo overlays.
- **Interactive Drag & Drop**: Click and drag directly on the preview canvas to position watermarks, or choose from 9 preset anchor points.

---

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
│   │   ├── panel/
│   │   │   ├── PanelSwitcher.tsx      <-- Added 'creativeExport' tab alongside adjust/crop/masks/presets/export
│   │   │   ├── BottomBar.tsx          <-- Direct Export Studio switcher in bottom status bar
│   │   │   ├── editor/
│   │   │   │   ├── ImageCanvas.tsx    <-- Core editor canvas mounting <CreativeExportOverlay />
│   │   │   │   ├── EditorToolbar.tsx  <-- Proof Export Frame ('F') toggle button
│   │   │   │   └── overlays/
│   │   │   │       └── CreativeExportOverlay.tsx <-- 60fps real-time framing/badge/watermark overlay
│   │   │   └── right/
│   │   │       ├── CreativeExportTab.tsx  <-- Mats, polaroids, keylines, EXIF badges, watermarks, presets & resets
│   │   │       ├── StandardExportTab.tsx  <-- Formats, quality, dimensions, filename templates, collages & splitters
│   │   │       ├── ExportPanel.tsx        <-- Unified export runner delegating to useExportStore
│   │   │       └── ExportCommons.tsx      <-- Shared Section accordions, formatExifSummary & helpers
│   │   └── ui/
│   │       ├── ExportImportProperties.tsx <-- Complete TypeScript interface definitions
│   │       └── ErrorBoundary.tsx          <-- Defensive React error boundary for export panels
│   ├── store/
│   │   ├── useExportStore.ts     <-- Unified store with localStorage per-image retention & preset manager
│   │   └── useUIStore.ts         <-- Panel states, proofExportFrame toggle, and active photo selection
│   ├── hooks/
│   │   ├── useExportSettings.ts  <-- Reactive facade delegating to useExportStore
│   │   ├── useKeyboardShortcuts.ts <-- 'F' proof toggle and export shortcut handlers
│   │   └── useLibraryStore.ts    <-- Image list and multiSelectedPaths store
│   └── i18n/locales/
│       └── en.json                <-- Localization strings
```

---

## 📂 Included Files & Patch Versions

| File | Version | Description |
| :--- | :--- | :--- |
| [`creative-export-borders-and-grids-v2.patch`](./creative-export-borders-and-grids-v2.patch) | **v2 (Active / Recommended)** | **Standalone v2 Patch**: Neatly integrates Creative Export Studio directly into the default Image Editor with single-canvas 60fps proofing, Proof Frame (`F`), per-image retention in `localStorage`, and preset manager. Applies in a single step against upstream RapidRAW (`main` / `v1.6.4`). |
| [`creative-export-borders-and-grids-v1.patch`](./creative-export-borders-and-grids-v1.patch) | **v1 (Legacy)** | **Original v1 Patch**: Offers creative export explicitly inside the export tab as a creative export feature. Retained for archival reference; will eventually be deprecated. |
| [`creative-export-borders-and-grids.patch`](./creative-export-borders-and-grids.patch) | **v2 (Default Alias)** | Convenience alias matching `creative-export-borders-and-grids-v2.patch` for automated build scripts and tooling. |
| [`RapidRAW_1.6.4_aarch64.dmg`](./RapidRAW_1.6.4_aarch64.dmg) | **v2 Build** | Production Apple Silicon macOS installer built from v2. |
| [`docs/EXPORT_STUDIO_GUIDE.md`](./docs/EXPORT_STUDIO_GUIDE.md) | Documentation | Comprehensive user manual, architecture guide, and token reference. |
| [`build-creative-export-borders-and-grids.sh`](./build-creative-export-borders-and-grids.sh) | Build Automation | Automated local build script that applies v2 (default) or v1 and builds macOS DMG. |
| [`update-and-build.sh`](./update-and-build.sh) | Build Automation | Convenience wrapper for updating upstream and building the DMG. |
| [`.github/workflows/auto-release.yml`](./.github/workflows/auto-release.yml) | CI/CD | Continuous cloud automation: monitors upstream, applies v2 patch, builds macOS, Windows & Linux, and publishes releases. |
| [`.github/workflows/build-macos.yml`](./.github/workflows/build-macos.yml) | CI/CD | On-demand macOS compilation workflow. |
| [`.github/workflows/build-windows.yml`](./.github/workflows/build-windows.yml) | On-demand Windows compilation workflow. |
| [`.github/workflows/build-linux.yml`](./.github/workflows/build-linux.yml) | CI/CD | On-demand Linux compilation workflow. |

> [!NOTE]
> **Deprecation Notice (Intermediate Export Studio)**:
> The intermediate prototype that introduced a separate export view window (`activeView: 'export'`) with a duplicate preview canvas has been **deprecated and removed** from this repository. All development and release assets are now consolidated on **v2**.

---

## 💻 Local Development & Building

### Option A: Automated Local Rebuild
```bash
# Build v2 against latest main branch (Default):
./build-creative-export-borders-and-grids.sh

# Build v2 against a specific upstream tag:
./build-creative-export-borders-and-grids.sh v1.6.4

# Build v1 (legacy):
./build-creative-export-borders-and-grids.sh main v1
```

### Option B: Manual Single-Patch Workflow (v2)
```bash
# 1. Clone RapidRAW
git clone https://github.com/CyberTimon/RapidRAW.git
cd RapidRAW

# 2. Apply v2 Patch in a single clean step
git apply --ignore-whitespace /path/to/creative-export-borders-and-grids-v2.patch

# 3. Install dependencies and compile
npm ci
npm run tauri -- build --bundles dmg --no-sign
```

---

## ⌨️ Keyboard & Mouse Shortcuts

| Shortcut / Gesture | Location | Action |
| :--- | :--- | :--- |
| `F` | Editor View | Toggle **Proof Export Frame** on/off |
| `Cmd` / `Ctrl` + `E` | Any View | Open / Toggle Export Panel |
| `Cmd` / `Ctrl` + Click | Filmstrip / Grid | Toggle photo in multi-selection |
| `Shift` + Click | Filmstrip / Grid | Select contiguous range of photos |
| Click | Filmstrip / Grid | Select and edit photo |
| Trackpad Pinch / Wheel | Editor Canvas | Smooth zoom in / zoom out |
| Click & Drag | Canvas Preview | Reposition watermark interactively |

---

## ⚠️ Upstream Maintenance & Conflicts

The **v2 Patch (`creative-export-borders-and-grids-v2.patch`)** is a clean, consolidated diff directly against upstream RapidRAW.

If upstream RapidRAW modifies surrounding navigation or export files in future versions:
```bash
git apply --reject creative-export-borders-and-grids-v2.patch
```
Inspect any generated `.rej` files and resolve the contextual changes.

---

## 📄 License & Acknowledgments

- **RapidRAW** is created by [Timon Käch (CyberTimon)](https://github.com/CyberTimon) and licensed under the **[GNU Affero General Public License v3 (AGPL-3.0)](https://www.gnu.org/licenses/agpl-3.0)**.
- This extension and all associated scripts and workflows are distributed under the same **AGPL-3.0** license.
