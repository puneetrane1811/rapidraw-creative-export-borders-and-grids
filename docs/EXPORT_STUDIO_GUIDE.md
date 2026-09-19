# RapidRAW: Export Studio & Creative Export Guide 🎨📐

Welcome to the comprehensive reference and user manual for **RapidRAW: Export Studio & Creative Export**.

This guide covers the architecture, user interface layout, keyboard/mouse controls, configuration parameters, per-image retention, preset management, and Rust processing pipelines powering RapidRAW's unified Creative Export Studio.

---

## Table of Contents

1. [Overview & Philosophy](#1-overview--philosophy)
2. [Interface Anatomy](#2-interface-anatomy)
   - [Panel Switcher & Navigation](#panel-switcher--navigation)
   - [Single-Canvas Live Proofing Engine](#single-canvas-live-proofing-engine)
   - [Proof Export Frame Toolbar Button (`F`)](#proof-export-frame-toolbar-button-f)
   - [Creative Export Tab](#creative-export-tab)
   - [Standard Export Tab & Collages / Splitters](#standard-export-tab--collages--splitters)
   - [Filmstrip & Multi-Selection](#filmstrip--multi-selection)
3. [Per-Image Retention & Granular Reverts](#3-per-image-retention--granular-reverts)
   - [Per-Photo Persistent Retention](#per-photo-persistent-retention)
   - [Section-Level & Master Reverts](#section-level--master-reverts)
4. [Creative Presets & Batch Processing](#4-creative-presets--batch-processing)
   - [Built-In Gallery Presets](#built-in-gallery-presets)
   - [Custom User Presets](#custom-user-presets)
   - [Batch Apply to All Selected Photos](#batch-apply-to-all-selected-photos)
5. [Feature Reference](#5-feature-reference)
   - [Fine-Art Mats & Polaroids](#fine-art-mats--polaroids)
   - [Museum Inset Keylines (Fillets)](#museum-inset-keylines-fillets)
   - [EXIF Camera Badges & Technical Framing](#exif-camera-badges--technical-framing)
   - [Text & Logo Watermarks](#text--logo-watermarks)
   - [Standard Export & Sizing](#standard-export--sizing)
   - [Grid Export (Collages / Contact Sheets)](#grid-export-collages--contact-sheets)
   - [Multi-Tile Grid Splitter (Instagram Slicing)](#multi-tile-grid-splitter-instagram-slicing)
   - [Composition Grid Overlays](#composition-grid-overlays)
   - [Dynamic Filename Template Engine](#dynamic-filename-template-engine)
6. [Architecture & Implementation](#6-architecture--implementation)
   - [Single-Canvas Component Hierarchy](#single-canvas-component-hierarchy)
   - [Reactive State & Storage Architecture](#reactive-state--storage-architecture)
   - [Backend Rust Processing Pipelines](#backend-rust-processing-pipelines)
7. [Dual-Patch Modular Maintenance](#7-dual-patch-modular-maintenance)
8. [Keyboard & Mouse Shortcuts Reference](#8-keyboard--mouse-shortcuts-reference)
9. [Dynamic Token Reference](#9-dynamic-token-reference)

---

## 1. Overview & Philosophy

Traditional RAW editors often isolate export into rigid modal dialogs or small sidebar panes with tiny preview thumbnails. Photographers preparing fine-art prints, social carousels, or client proof sheets are forced into blind guesswork or secondary applications like Photoshop, Lightroom Print, or command-line scripts.

In earlier development iterations, export was moved to a separate standalone view. However, running a duplicate canvas introduced unnecessary memory overhead, view-switching friction, and state divergence.

**RapidRAW Creative Export Studio** solves this with a **Single-Canvas Architecture** integrated directly into the core Image Editor:
- **Zero Redundant Canvases**: The active developed image is rendered once by the editor's high-performance pipeline. The creative framing layer (`CreativeExportOverlay.tsx`) mounts directly inside the editor canvas, panning and zooming in 100% synchrony with `TransformWrapper`.
- **Non-Destructive Proofing Toggle (`F`)**: Toggle framing, mats, badges, and watermarks on or off at any moment without leaving your editing flow.
- **Per-Image Retention**: Just like RAW exposure and tone curve adjustments, creative framing parameters are preserved on a per-photo basis across sessions.
- **One-Click Presets & Batch Styling**: Apply professional museum mats or instant film aesthetics in 1 click, or batch-apply them across dozens of selected photos simultaneously.
- **Zero Generation Loss**: Slices, borders, badges, and mats are rasterized directly from 16-bit buffers during the final export pass.

---

## 2. Interface Anatomy

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ RapidRAW  [Library]  [Editor]                                  [ - □ ✕ ]    │
├─────────────────────────────────────────────────┬───────────────────────────┤
│ TOOLBAR: [Undo] [Redo] [Zoom] [ ✨ Proof (F) ]   │ PANEL SWITCHER:           │
├─────────────────────────────────────────────────┤ [Adjust][Crop][Presets]   │
│                                                 │ [Export Studio] [Export]  │
│                   IMAGE EDITOR                  ├───────────────────────────┤
│                   SINGLE CANVAS                 │ Creative Export Settings  │
│              (Pan / Zoom Synchronous)           │ ───────────────────────── │
│                                                 │ 📁 Presets [Save] [Apply] │
│      ┌───────────────────────────────────┐      │ 🖼️ Framing & Polaroid [↺] │
│      │  Outer Mat Border                 │      │ 📏 Inset Keyline       [↺] │
│      │   ┌─────────────┬─────────────┐   │      │ 📷 EXIF Camera Badge   [↺] │
│      │   │   Photo 1   │   Photo 2   │   │      │ 🔤 Watermark (Text/Img)[↺] │
│      │   ├─────────────┼─────────────┤   │      │ ───────────────────────── │
│      │   │   Photo 3   │   Photo 4   │   │      │ [ Reset All Filters ]     │
│      │   └─────────────┴─────────────┘   │      │ [ Proceed to Export → ]   │
│      │  📷 SONY A7IV • 50mm f/1.8 • ISO100│     │                           │
│      └───────────────────────────────────┘      │                           │
├─────────────────────────────────────────────────┴───────────────────────────┤
│ BOTTOM FILMSTRIP: [✓ Photo 1] [✓ Photo 2] [✓ Photo 3] [✓ Photo 4] ...        │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Panel Switcher & Navigation
The right-hand panel switcher hosts:
- **`Adjust`**: Core RAW exposure, color balance, tone curves, and detail.
- **`Crop`**: Geometry, rotation, perspective, and aspect ratio cropping.
- **`Masks` & `Inpaint`**: Local adjustments and AI inpainting.
- **`Presets`**: Color grading and film simulation presets.
- **`Export Studio`**: Framing mats, polaroid formats, inset keylines, EXIF badges, and watermarks.
- **`Export`**: Standard export formats, quality, sizing, filename templates, real-time multi-photo collage grids, and tile splitters.

### Single-Canvas Live Proofing Engine
- The creative overlay (`CreativeExportOverlay.tsx`) mounts directly inside `ImageCanvas.tsx`.
- Runs at 60fps with zero flicker or latency.
- Scales, pans, and magnifies in perfect hardware-accelerated lockstep with the editor's `TransformWrapper`.
- **Live Multi-Photo Collage Compositing**: When photo collage mode is enabled in the final Export tab, the center canvas automatically lays out all selected photos in real time inside the configured grid ($N \times M$), complete with custom gutter spacing, cell fit modes, and outer framing.

### Proof Export Frame Toolbar Button (`F`)
- Located in `EditorToolbar.tsx` with a sparkles icon (`✨`).
- Press <kbd>F</kbd> on your keyboard or click the toolbar icon to toggle the creative framing overlay on/off at any time.

### Creative Export Tab
- Dedicated exclusively to creative finishing aesthetics: **Presets**, **Framing & Polaroid**, **Inset Keyline**, **EXIF Camera Badge**, and **Watermarks**.
- Every accordion includes an independent section revert button (`RotateCcw`).
- Includes a master **Reset All Creative Filters** button and a **Proceed to Export →** button that automatically navigates to the Export tab.

### Standard Export Tab & Collages / Splitters
- Dedicated to final output generation:
  - File formats (JPEG, PNG, TIFF, WebP) and quality controls.
  - Sizing constraints and output dimensions.
  - Dynamic token-based filename templates.
  - **Grid Export (Collages)**: Combine selected photos into $N \times M$ contact sheets.
  - **Multi-Tile Grid Splitter**: Slice images into $N \times M$ tiles for Instagram carousels.
  - **Composition Grid Overlays**: Rule of Thirds ($3 \times 3$) and custom guides.

### Filmstrip & Multi-Selection
- The persistent horizontal filmstrip at the bottom allows instant photo switching.
- <kbd>Cmd</kbd> / <kbd>Ctrl</kbd> + click adds/removes individual photos into multi-selection.
- <kbd>Shift</kbd> + click selects contiguous ranges.
- Selecting photos retains each image's custom creative configuration without view redirects.

---

## 3. Per-Image Retention & Granular Reverts

### Per-Photo Persistent Retention
Every photo's creative parameters are automatically preserved in `useExportStore` and synchronized with browser `localStorage` under `rapidraw_creative_settings_by_path`:
- When you customize the mat border or EXIF badge for `photo_A.raw`, those settings remain assigned specifically to `photo_A.raw`.
- Navigating to `photo_B.raw` loads `photo_B`'s unique setup.
- When you return to `photo_A.raw`, its framing, colors, badges, and watermarks are restored instantly.
- State persists reliably across application restarts.

### Section-Level & Master Reverts
- **Section Reset Buttons (`RotateCcw`)**: Click the revert icon in the header of any tool section (Framing, Polaroid, Inset Keyline, EXIF Badge, or Watermark) to restore only that section back to factory defaults.
- **Individual Slider Defaults**: Double-click or reset individual numeric values.
- **Master Reset**: Click **Reset All Creative Filters** at the bottom of the drawer to reset all creative parameters for the active photo to a clean slate.

---

## 4. Creative Presets & Batch Processing

### Built-In Gallery Presets
Quickly apply curated finishing styles with 1 click:
1. **Fine-Art Gallery Mat**: Exhibition-grade 5% white mat with balanced borders.
2. **Museum Dark Framing**: Archival dark-grey mat with an inset hairline keyline.
3. **Classic Polaroid 600**: Vintage instant-film aesthetic with a $2.8\times$ bottom chin.
4. **Technical Exposure Strip**: Integrated camera model, lens metadata, and exposure strip.
5. **Minimalist Social Pill**: Floating translucent glass badge in the bottom-right corner.

### Custom User Presets
- Create your own look by tweaking borders, badges, and watermarks.
- Enter a name in the **Save Preset** field and click **Save**.
- Your custom preset appears in the presets bar with a delete button for easy management.

### Batch Apply to All Selected Photos
- Select multiple photos in the bottom filmstrip using <kbd>Cmd</kbd>/<kbd>Ctrl</kbd> + click or <kbd>Shift</kbd> + click.
- Dial in your preferred creative look or select a preset.
- Click **Apply to All Selected Photos**.
- The active creative configuration is immediately propagated to every selected photo and saved to persistent storage!

---

## 5. Feature Reference

### Fine-Art Mats & Polaroids
- **Outer Mat Border**: Uniform border framing (0.5% to 50% of image dimensions) with full hex color customization.
- **Polaroid Format**: Elongated bottom chin multiplier ($1.0\times$ to $5.0\times$) recreating authentic instant film proportions.

### Museum Inset Keylines (Fillets)
- Contrasting hairline inner border inset at any distance inside the outer mat.
- **Inset Distance**: Slider controls distance from the photo edge into the mat.
- **Stroke Width**: 1px to 10px.
- **Independent Color**: Pair a dark mat with an off-white keyline or a white mat with a black hairline.

### EXIF Camera Badges & Technical Framing
- **Matte Bottom Strip ("Gallery Frame")**:
  - Extends the bottom border with an elegant 2-line technical strip.
  - **Left**: Camera Make & Model, Lens, and Photographer Signature / Credit.
  - **Right**: Optical Exposure Settings (ƒ-number, Shutter Speed, ISO, Focal Length) and Capture Date.
  - Centered alignment dynamically adjusted across single or multi-photo layouts.
- **Floating Glass Pill ("Social Badge")**:
  - Translucent pill overlay with rounded corners positioned in the bottom-right corner.
  - Granular metadata toggles for Camera, Lens, Exposure, and Date.
  - Customizable opacity, blur, and color palette.

### Text & Logo Watermarks
- **Text Watermark**: Custom text rendered via embedded DejaVuSans TrueType font with drop-shadow for legibility over bright or dark areas.
- **Logo Watermark**: PNG/JPG/WebP image overlay with alpha transparency.
- **Interactive Drag Placement**: Click and drag directly on the preview canvas to position watermarks, or choose from 9 preset anchor points.
- **Opacity Slider**: Smooth 1% to 100% alpha blending.

### Standard Export & Sizing
- Formats: JPEG (quality 1–100), PNG, TIFF (8-bit or 16-bit), WebP (lossy / lossless).
- Sizing constraints: Original, Fit to Width, Fit to Height, Long Edge, Short Edge, or Custom Megapixels.
- Sharpening on export: None, Low, Standard, High.

### Grid Export & Real-Time Photo Collage Proofing
- **Live Center-Canvas Proofing**: When "Enable Photo Collage" is toggled on and two or more photos are selected in the filmstrip, the editor canvas instantly transitions from single-image view to a live composite grid layout.
- **Dynamic Viewport Aspect Ratio**: The editor automatically computes the composite grid's total bounding dimensions ($W_{\text{grid}} \times H_{\text{grid}}$), taking into account the cell dimensions, column/row count, and gutter spacing. The image render size and zoom/pan viewport immediately adapt to center the collage with zero clipping.
- **Unified Creative Framing**: Outer mat borders, museum inset keylines, EXIF bottom strip badges, and watermark signatures wrap seamlessly around the entire multi-photo collage.
- **Configurable Dimensions**: Adjustable grid columns (1–10) and rows (1–10) with live size badge indicators.
- **Cell Sizing Modes**:
  - **Fit (Letterbox)**: Preserves original aspect ratios within each cell without cropping.
  - **Fill (Center-Crop)**: Fills each cell entirely for a clean, uniform, border-to-border aesthetic.
- **Gutter Spacing**: Adjustable inner cell margins (0% to 10%) with background color matching the active mat border.
- **Granular Reset**: Instant revert button (`RotateCcw`) in both the Export Studio and Export tabs to reset collage grid settings without impacting other creative filters.

### Multi-Tile Grid Splitter (Instagram Slicing)
- Slices the processed photo into an $N \times M$ grid of separate files.
- Ideal for panoramic Instagram carousels and $3 \times 3$ grid profile mosaics.
- Optional border padding applied per individual tile.

### Composition Grid Overlays
- Rule of Thirds ($3 \times 3$) or custom $N \times M$ grid lines.
- Proof composition, horizon alignment, and visual balance.
- Adjustable grid color, opacity slider, and line thickness.

### Dynamic Filename Template Engine
- Robust token-based output file naming for single and batch exports:
  - `{original_filename}`, `{camera}`, `{lens}`, `{iso}`, `{focal}`, `{aperture}`, `{shutter}`, `{date}`, `{time}`, `{seq}`.
- **Live Resolved Preview**: Dynamically previews the generated filename under the template input.
- **Filesystem Sanitization**: Automatically cleans illegal characters (`/`, `\`, `:`, `*`, `?`, `"`, `<`, `>`, `|`).

---

## 6. Architecture & Implementation

### Single-Canvas Component Hierarchy

```
src/
├── App.tsx                        <-- Global router & panel registrar
├── components/
│   ├── panel/
│   │   ├── PanelSwitcher.tsx      <-- 'creativeExport' & 'export' tab registration
│   │   ├── BottomBar.tsx          <-- Status bar with 1-click Export Studio switcher
│   │   ├── editor/
│   │   │   ├── ImageCanvas.tsx    <-- Editor canvas mounting <CreativeExportOverlay />
│   │   │   ├── EditorToolbar.tsx  <-- Proof Export Frame ('F') toggle button
│   │   │   └── overlays/
│   │   │       └── CreativeExportOverlay.tsx <-- 60fps real-time framing/badge/watermark overlay
│   │   └── right/
│   │       ├── CreativeExportTab.tsx  <-- Mats, polaroids, keylines, EXIF badges, watermarks, presets & resets
│   │       ├── StandardExportTab.tsx  <-- Formats, quality, dimensions, filename templates, collages & splitters
│   │       ├── ExportPanel.tsx        <-- Unified export runner delegating to useExportStore
│   │       └── ExportCommons.tsx      <-- Shared Section accordions, formatExifSummary & helpers
│   └── ui/
│       ├── ExportImportProperties.tsx <-- Complete TypeScript interface definitions
│       └── ErrorBoundary.tsx          <-- Defensive React error boundary for export panels
├── store/
│   ├── useExportStore.ts     <-- Unified store with localStorage per-image retention & preset manager
│   └── useUIStore.ts         <-- Panel states, proofExportFrame toggle, and active photo selection
└── hooks/
    ├── useExportSettings.ts  <-- Reactive facade delegating to useExportStore
    ├── useKeyboardShortcuts.ts <-- 'F' proof toggle and export shortcut handlers
    └── useLibraryStore.ts    <-- Image list and multiSelectedPaths store
```

### Reactive State & Storage Architecture
1. **`useExportStore`**:
   - Manages all standard export options and creative export options in a single reactive Zustand store.
   - `imageCreativeSettings`: Dictionary keyed by file path (`Record<string, CreativeExportOptions>`).
   - `activeImagePath`: Synchronized with `useUIStore.activePhotoIndex`.
   - On image switch, `loadImageCreativeSettings(path)` loads saved settings or creates defaults.
   - Persisted to `localStorage` under `rapidraw_creative_settings_by_path`.
2. **`CreativeExportOverlay`**:
   - Mounts inside `ImageCanvas.tsx` at the exact render size of the developed photo.
   - Positioned with `zIndex: 25` and `overflow: visible` to render outer mats beyond the photo bounds.
   - Inherits `TransformWrapper` zoom and pan coordinates automatically with zero lag.

### Backend Rust Processing Pipelines
Located in `src-tauri/src/export_processing.rs`:
- **`process_creative_export`**: High-performance pipeline applying mats, keylines, badges, and watermarks to developed 16-bit RGB buffers.
- **`render_grid_collage`**: Multi-image contact sheet assembler supporting fit and fill modes with cell gutters.
- **`slice_grid_tiles`**: Multi-tile splitter slicing images into individual raster files with optional tile borders.
- **`file_management.rs`**: Dynamic token parser resolving camera EXIF metadata and timestamp values into sanitized filenames.

---

## 7. Patch Versions & Maintenance (v2 Recommended, v1 Legacy)

This repository maintains two distinct patch versions against upstream RapidRAW:

```
Upstream RapidRAW (v1.6.4 / main)
   │
   ├── [v2 Patch - Active / Recommended] creative-export-borders-and-grids-v2.patch
   │   (Direct Editor integration, single-canvas overlay, Proof Frame 'F', per-image retention, preset manager)
   │
   └── [v1 Patch - Legacy] creative-export-borders-and-grids-v1.patch
       (Original version: creative export offered explicitly inside the export tab; will eventually be deprecated)
```

> [!NOTE]
> **Deprecation Notice (Intermediate Export Studio)**:
> The intermediate development prototype that featured a separate export view window (`activeView: 'export'`) with a duplicate preview canvas has been **permanently deprecated and removed**. All active development is concentrated on **v2**.

### Applying the v2 Patch Manually (Single Step)
```bash
git clone https://github.com/CyberTimon/RapidRAW.git
cd RapidRAW

# Apply v2 Patch in a single clean step
git apply --ignore-whitespace /path/to/creative-export-borders-and-grids-v2.patch

# Build macOS DMG
npm ci
npm run tauri -- build --bundles dmg --no-sign
```

### Applying the v1 Patch (Legacy)
```bash
git apply --ignore-whitespace /path/to/creative-export-borders-and-grids-v1.patch
```

---

## 8. Keyboard & Mouse Shortcuts Reference

| Shortcut / Gesture | Context | Action |
| :--- | :--- | :--- |
| `F` | Editor View | Toggle **Proof Export Frame** on/off |
| `Cmd` / `Ctrl` + `E` | Any View | Open / Toggle Export Panel |
| `Cmd` / `Ctrl` + Click | Filmstrip / Grid | Toggle photo in multi-selection |
| `Shift` + Click | Filmstrip / Grid | Select contiguous range of photos |
| Click | Filmstrip / Grid | Select and edit photo |
| Trackpad Pinch / Wheel | Editor Canvas | Smooth zoom in / zoom out |
| Click & Drag | Watermark on Canvas | Reposition watermark interactively |

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
