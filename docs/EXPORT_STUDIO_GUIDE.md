# RapidRAW: Export Studio & Creative Export Guide 🎨📐

Welcome to the comprehensive reference and user manual for **RapidRAW: Export Studio & Creative Export**.

This guide covers the full architecture, user interface layout, keyboard/mouse controls, configuration parameters, and Rust processing pipelines introduced in RapidRAW's Center Stage Export Studio.

---

## Table of Contents

1. [Overview & Philosophy](#1-overview--philosophy)
2. [Interface Anatomy](#2-interface-anatomy)
   - [Top Navigation Bar](#top-navigation-bar)
   - [Center Stage Live Preview Canvas](#center-stage-live-preview-canvas)
   - [Floating Darkroom Zoom Toolbar](#floating-darkroom-zoom-toolbar)
   - [Bottom Filmroll Photo Roll](#bottom-filmroll-photo-roll)
   - [Creative Settings Sidebar Drawer](#creative-settings-sidebar-drawer)
   - [Standard Export Sidebar (Library / Editor Mode)](#standard-export-sidebar)
3. [Interactive Zoom & Viewport Controls](#3-interactive-zoom--viewport-controls)
4. [Filmroll Multi-Selection & Curation](#4-filmroll-multi-selection--curation)
5. [Feature Reference](#5-feature-reference)
   - [Fine-Art Mats & Inset Keylines](#fine-art-mats--inset-keylines)
   - [EXIF Camera Badge & Technical Framing](#exif-camera-badge--technical-framing)
   - [Dynamic Filename Template Engine](#dynamic-filename-template-engine)
   - [Composition & Slicing Tools](#composition--slicing-tools)
     - [Composition Grid Overlay](#composition-grid-overlay)
     - [Multi-Tile Grid Splitter](#multi-tile-grid-splitter)
   - [Multi-Photo Contact Sheet / Grid Collage](#multi-photo-contact-sheet--grid-collage)
   - [Text & Image Watermarks](#text--image-watermarks)
6. [Architecture & Implementation](#6-architecture--implementation)
   - [Frontend Component Hierarchy](#frontend-component-hierarchy)
   - [State Management & Custom Hooks](#state-management--custom-hooks)
   - [Backend Rust Pipelines](#backend-rust-pipelines)
7. [Dual-Patch Modular Maintenance](#7-dual-patch-modular-maintenance)
8. [Keyboard & Mouse Shortcuts Reference](#8-keyboard--mouse-shortcuts-reference)
9. [Dynamic Token Reference](#9-dynamic-token-reference)

---

## 1. Overview & Philosophy

Traditional RAW editors often treat file export as a modal dialog or narrow sidebar tab. Photographers who want to add fine-art mats, technical camera badges, watermarks, Instagram slice grids, or contact-sheet collages are forced to either guess parameters blindly or jump into external tools like Photoshop, Lightroom Print, or terminal scripts.

**RapidRAW Export Studio** reimagines exporting as a dedicated, distraction-free creative darkroom:

- **Expansive Center Stage Canvas**: Live 60fps HTML5 visual proofing occupying the primary screen real estate.
- **Integrated Bottom Film Roll**: Select, curate, and multi-select photos for batch or collage processing without context-switching back to the Library.
- **Strict Separation of Concerns**:
  - **Sidebar Standard Export**: Focused exclusively on compression, color profile, output dimensions, and destination folders.
  - **Center Stage Export Studio**: A dedicated workspace for creative framing, composition, slicing, branding, and interactive proofing.
- **Zero-Generation Quality Loss**: All borders, text badges, keylines, and slices are rendered directly from 16-bit raster buffers during the final export pass.

---

## 2. Interface Anatomy

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ RapidRAW  [Library]  [Editor]  [Export Studio]                 [ - □ ✕ ]    │
├─────────────────────────────────────────────────┬───────────────────────────┤
│                                                 │ Creative Export Settings  │
│                                                 │ ───────────────────────── │
│                   CENTER STAGE                  │ 📁 Presets                │
│                LIVE PREVIEW CANVAS              │ 🖼️ Framing & Borders       │
│                                                 │    • Mat Size & Color     │
│             [ - ] [ 100% ] [ + ] [ ↺ Fit ]      │    • Inset Keyline        │
│                                                 │ 📷 EXIF Camera Badge      │
│                                                 │    • Gallery Bottom Strip │
│                                                 │    • Floating Glass Pill  │
│                                                 │ 🔲 Composition & Slicing  │
│                                                 │    • Grid Overlay         │
│                                                 │    • Multi-Tile Splitter  │
│                                                 │ 🏷️ Dynamic Filename       │
│                                                 │ 🔤 Watermark (Text/Logo)  │
│                                                 │ ───────────────────────── │
│                                                 │ [ Export 1 Photo ]        │
├─────────────────────────────────────────────────┴───────────────────────────┤
│ BOTTOM FILM ROLL: [✓ Photo 1] [  Photo 2] [✓ Photo 3] [  Photo 4] ...       │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Top Navigation Bar
- **Export Studio Button**: Located in the top header and bottom status bar. Clicking it transitions RapidRAW into the full-screen Export Studio workspace (`activeView: 'export'`).

### Center Stage Live Preview Canvas
- Occupies the central viewport with darkroom-styled checkerboard canvas backing.
- Renders real-time visual proofing of all active mats, keylines, EXIF badges, grid lines, watermarks, and collage layouts.
- Auto-scales dynamically to fit the viewport based on single vs. multi-image aspect ratios.

### Floating Darkroom Zoom Toolbar
Positioned at the top-right of the preview stage:
- **Zoom Out (`-`)**: Decrements scale by 10% (minimum 25%).
- **Zoom Indicator (`100%`)**: Displays current magnification percentage.
- **Zoom In (`+`)**: Increments scale by 10% (maximum 300%).
- **Fit View (`↺ Fit`)**: Resets zoom to automatically fit the canvas within the viewport bounds.

### Bottom Filmroll Photo Roll
- Displays horizontal thumbnails of all imported photos with file names and multi-select checkboxes.
- Clicking any photo selects it for previewing adjustments and EXIF details **without** exiting the Export Studio.
- Supports batch multi-selection via `Cmd` / `Ctrl` + click and `Shift` + click.

### Creative Settings Sidebar Drawer
- Right-hand control drawer hosting collapsible accordions for all creative finishing tools.
- Real-time parameter changes immediately update the center stage canvas.
- Features a persistent bottom export footer with dynamic button text (e.g., `Export 1 Photo`, `Export 4 Selected Photos`, `Export 4-Photo Collage`).

### Standard Export Sidebar
- Available inside Library and Editor views via the right-hand panel.
- Dedicated strictly to standard export settings:
  - File format (JPEG, PNG, TIFF, WebP).
  - Quality, color space (sRGB, Display P3, Adobe RGB, ProPhoto RGB).
  - Output sizing, sharpening, and destination directory.
  - Features an **Open Export Studio** banner for quick one-click navigation to the full studio.

---

## 3. Interactive Zoom & Viewport Controls

| Action | Control | Description |
| :--- | :--- | :--- |
| **Zoom In** | `+` Button or `Cmd` + `Wheel Up` | Zooms in up to 300% for fine-detail proofing of keylines, watermarks, and EXIF typography. |
| **Zoom Out** | `-` Button or `Cmd` + `Wheel Down` | Zooms out down to 25% for broad layout overview. |
| **Fit to Screen** | `↺ Fit` Button | Instantly scales canvas to the maximum possible size within the stage without clipping. |
| **Pan / Scroll** | Mouse Drag / Scrollbar | When zoomed past 100%, smooth custom scrollbars allow natural darkroom panning. |
| **Auto-Fit on Change** | Automatic | Switching between single photos and multi-photo selections automatically triggers a recalculation to `'fit'` mode. |

---

## 4. Filmroll Multi-Selection & Curation

The bottom film roll eliminates repetitive back-and-forth navigation between the Library and Export views:

1. **Single Click**:
   - Updates the live preview to display the clicked image.
   - Pre-loads image adjustments and extracts camera EXIF metadata into the technical badge.
   - **Crucial**: Does *not* redirect you to the Editor; keeps you securely in the Export Studio.
2. **`Cmd` / `Ctrl` + Click**:
   - Toggles selection for individual photos into `multiSelectedPaths`.
   - Automatically checks or unchecks the thumbnail badge.
   - Preserves all existing selections without clearing them.
3. **`Shift` + Click**:
   - Selects a contiguous range of photos from the last clicked item to the current item.
4. **Card Checkbox Click**:
   - Directly toggles multi-select inclusion for that specific photo.

---

## 5. Feature Reference

### Fine-Art Mats & Inset Keylines
- **Outer Mat Border**:
  - Adds an outer border around the image, specified as a percentage of the image dimensions (0.5% to 50%).
  - Fully customizable mat color via hex code or visual color picker.
- **Inset Keyline (Fillet)**:
  - Museum-grade fine hairline border positioned inside the outer mat.
  - Inset distance slider controls distance from the photo edge into the mat.
  - Independent color picker (e.g., crisp black keyline on white mat).
  - Thickness controls (1px to 10px).

### EXIF Camera Badge & Technical Framing
- **Matte Bottom Strip ("Gallery Frame")**:
  - Extends the bottom border with a gallery matte strip.
  - Left column: Camera model, lens metadata, and custom photographer credit.
  - Right column: Exposure parameters (ƒ-number, shutter speed, ISO, focal length) and capture date.
  - Centered alignment across multi-image collages.
- **Floating Glass Pill ("Social Badge")**:
  - Translucent pill overlay with rounded corners positioned in the bottom-right corner.
  - Granular metadata toggles for Camera, Lens, Exposure, and Date.
  - Custom background opacity, blur, and font palette colors.

### Dynamic Filename Template Engine
- Available for both single-image and batch exports.
- Supported tokens:
  - `{original_filename}`: Base name of the input RAW/image file.
  - `{camera}`: Camera make and model (e.g. `Sony-ILCE-7M4`).
  - `{lens}`: Mounted optical lens (e.g. `FE-24-70mm-F2.8-GM-II`).
  - `{iso}`, `{aperture}`, `{shutter}`, `{focal}`: Exposure values.
  - `{date}`, `{time}`, `{YYYY}`, `{MM}`, `{DD}`: Timestamp tokens.
  - `{seq}` or `{sequence}`: 2-digit zero-padded index (`01`, `02`, ...).
- Automatic filesystem sanitization replacing illegal characters (`/`, `\`, `:`, `*`, `?`, `"`, `<`, `>`, `|`) with hyphens.

### Composition & Slicing Tools
Unified under a single **Composition & Slicing** accordion:
1. **Composition Grid Overlay**:
   - Rule of Thirds ($3 \times 3$) or custom $N \times M$ grid lines.
   - Proof composition, horizon alignment, and visual balance.
   - Adjustable grid color, opacity slider, and line thickness.
2. **Multi-Tile Grid Splitter**:
   - Slices the processed photo into an $N \times M$ grid of separate files.
   - Ideal for panoramic Instagram carousels and $3 \times 3$ grid profile mosaics.
   - Optional border padding applied per individual tile.

### Multi-Photo Contact Sheet / Grid Collage
- Assembles multiple selected photos into a unified contact sheet or collage.
- Configurable grid columns and rows.
- **Cell Sizing Modes**:
  - **Fit (Letterbox)**: Preserves original aspect ratio without cropping.
  - **Fill (Center-Crop)**: Fills each cell entirely for uniform layout.
- Customizable cell gutters (inner spacing) and outer mat borders.

### Text & Image Watermarks
- **Text Watermark**: Custom text rendered via embedded DejaVuSans TrueType font with drop-shadow for legibility over bright or dark areas.
- **Logo Watermark**: PNG/JPG/WebP image overlay with alpha transparency.
- **Interactive Drag Placement**: Click and drag directly on the preview canvas to position watermarks, or choose from 9 preset anchor points.
- **Opacity Slider**: Smooth 1% to 100% alpha blending.

---

## 6. Architecture & Implementation

### Frontend Component Hierarchy

```
src/
├── App.tsx                        <-- Global router; mounts ExportView when activeView === 'export'
├── components/
│   ├── views/
│   │   └── ExportView.tsx         <-- Center Stage Studio: stage, zoom bar, film roll, settings drawer
│   ├── panel/right/
│   │   ├── ExportPanel.tsx        <-- Sidebar Standard Export + "Launch Export Studio" banner
│   │   ├── StandardExportTab.tsx  <-- Formats, quality, dimensions, filename templates
│   │   ├── CreativeExportTab.tsx  <-- Mats, keylines, EXIF badges, collages, watermarks
│   │   ├── ExportLivePreview.tsx  <-- 60fps HTML5 Canvas preview, zoom engine, pan viewport
│   │   └── ExportCommons.tsx      <-- Section accordions, segmented buttons, GridNumberInput
│   └── ui/
│       ├── ErrorBoundary.tsx      <-- Crash-resilient error boundary protecting export views
│       └── ExportImportProperties.tsx <-- Complete TypeScript interfaces
└── hooks/
    ├── useAppNavigation.ts        <-- Navigation router; handleImageSelect with openInEditor flag
    └── useExportSettings.ts       <-- Export settings store, defaults, and preset sync
```

### Key Navigation Fix
`src/hooks/useAppNavigation.ts` defines:
```typescript
handleImageSelect: (path: string, openInEditor: boolean = true) => void
```
When called from `ExportView.tsx`, `openInEditor` is set to `false`. This prevents switching `activeView` to `'editor'` and preserves `multiSelectedPaths` in the Zustand store.

---

## 7. Dual-Patch Modular Maintenance

This repository provides two modular patches against upstream RapidRAW:

```
Upstream RapidRAW (v1.6.4 / main)
   │
   ├── [Patch 1] creative-export-borders-and-grids.patch
   │             (Core Rust backend, borders, EXIF badges, filename templates, watermarks)
   │
   └── [Patch 2] center-stage-creative-export-studio.patch
                 (Center Stage Export Studio, bottom film roll, zoom controls, isolated sidebar)
```

### Applying Both Patches Manually
```bash
git clone https://github.com/CyberTimon/RapidRAW.git
cd RapidRAW

# Step 1: Apply baseline creative export engine
git apply --ignore-whitespace ../creative-export-borders-and-grids.patch

# Step 2: Apply Center Stage Export Studio
git apply --ignore-whitespace ../center-stage-creative-export-studio.patch

# Step 3: Build macOS DMG
npm ci
npm run tauri -- build --bundles dmg --no-sign
```

---

## 8. Keyboard & Mouse Shortcuts Reference

| Shortcut / Gesture | Context | Action |
| :--- | :--- | :--- |
| `Cmd` / `Ctrl` + Click | Bottom Filmroll | Toggle photo in multi-selection |
| `Shift` + Click | Bottom Filmroll | Contiguous range selection |
| Click | Bottom Filmroll | Select and preview photo |
| `Cmd` / `Ctrl` + Scroll Wheel | Center Stage Canvas | Smooth Zoom In / Zoom Out |
| Click & Drag | Watermark on Canvas | Reposition watermark interactively |
| Click `↺ Fit` | Zoom Toolbar | Reset zoom to fit screen |
| Click `+` / `-` | Zoom Toolbar | Step zoom by ±10% |

---

## 9. Dynamic Token Reference

| Token | Description | Example Output |
| :--- | :--- | :--- |
| `{original_filename}` | Input filename without extension | `DSC01948` |
| `{camera}` | Sanitized camera make & model | `Sony-ILCE-7M4` |
| `{lens}` | Sanitized lens identifier | `FE-24-70mm-F2.8-GM-II` |
| `{iso}` | Sensor sensitivity | `ISO800` |
| `{focal}` | Focal length | `50mm` |
| `{aperture}` | Lens aperture ƒ-stop | `f2.8` |
| `{shutter}` | Shutter speed | `1-250s` |
| `{date}` | Capture date (YYYY-MM-DD) | `2026-09-18` |
| `{time}` | Capture time (HH-MM-SS) | `14-30-00` |
| `{seq}` | 2-digit sequence index | `01`, `02` |
