<div align="center">

# RapidRAW: Creative Export Studio ✨🖼️

**The high-performance RAW photo darkroom with fine-art finishing, dynamic EXIF badges, and museum-grade framing.**

[![License: AGPL v3](https://img.shields.io/badge/License-AGPL_v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)
[![macOS Support](https://img.shields.io/badge/macOS-Apple_Silicon-brightgreen.svg)]()
[![Windows Support](https://img.shields.io/badge/Windows-x64_NSIS-blue.svg)]()
[![Linux Support](https://img.shields.io/badge/Linux-AppImage_%7C_deb-orange.svg)]()
[![Release v2](https://img.shields.io/badge/Release-v2.0_Unified-purple.svg)](https://github.com/puneetrane1811/rapidraw-creative-export-borders-and-grids/releases)

---

### *RAW development is only half the photograph. Creative Export finishes the print.*

<br/>

<img src="docs/images/hero-canvas-proofing.png" alt="RapidRAW Creative Export Studio Live Canvas Proofing" width="100%" />

*Live canvas proofing of a fine-art Polaroid mat, museum inset keyline, and EXIF badge directly inside the RapidRAW editor.*

</div>

Most RAW editors stop at pixel adjustments, leaving photographers to wrestle with Photoshop, Lightroom Print, or command-line scripts just to add exhibition mats, camera badges, or Instagram slice carousels.

**Creative Export Studio v2** transforms **[RapidRAW](https://github.com/CyberTimon/RapidRAW)** into a complete creative darkroom. Seamlessly integrated into the core Image Editor, it lets you frame, badge, brand, and slice your photos directly over the live 16-bit canvas with zero quality loss and instant visual feedback.

---

## ✨ Why You’ll Love It

* **⚡ Single-Canvas Live Proofing**: No separate windows or duplicate canvases. Your mats, keylines, and badges render directly inside the editor canvas at a locked 60fps—synchronized with pan, pinch, and zoom.
* **👁️ Instant Proofing (<kbd>F</kbd>)**: Tap <kbd>F</kbd> on your keyboard or click the sparkles icon in the toolbar to toggle your fine-art frame over your live edit at any second.
* **💾 Per-Photo Memory**: Every image remembers its unique framing, mat color, and badge settings across sessions, exactly like RAW exposure and tone curve adjustments.
* **↺ Granular Reverts**: Revert individual adjustments (framing, keylines, or badges) independently without losing your other tweaks.
* **🎨 1-Click Presets & Batch Styling**: Apply classic gallery styles in one click, or batch-apply your look to every selected photo across the filmstrip.
* **🔬 Zero-Generation Loss**: Borders, gutters, and slice matrices render in a single high-performance pipeline directly from developed 16-bit raster buffers.

---

## 🎨 Creative Superpowers

<p align="center">
  <img src="docs/images/polaroid-exif-badge.png" width="48%" alt="Fine-Art Mat with Inset Keyline and EXIF Badge" />
  &nbsp;
  <img src="docs/images/export-studio-panel.png" width="48%" alt="Export Studio Controls Drawer" />
</p>
<p align="center">
  <em>Left: Live canvas proof with custom fine-art mat, contrasting inset keyline, Polaroid chin, and EXIF metadata. Right: The integrated Export Studio inspector controls drawer.</em>
</p>

### 🎞️ Curated Photographic Preset Families
- **Instant Family**: *Classic Polaroid 600*, *SX-70 Warm Chin*, *Instax Mini Frame*, *Instax Square Modern*, and *Wide Format Peel-Apart*.
- **Film Family**: *35mm Contact Frame*, *35mm Sprocket Holes* (authentic perforation geometry & generic edge markings), *Medium Format 6x6 Rebate*, *Medium Format 6x7 Border*, and *Large Format 4x5 Sheet Film*.
- **Editorial Family**: *Fine-Art Gallery Mat*, *Museum Dark Framing*, *Minimalist Keyline Float*, *Magazine Spread Margin*, and *Exhibition Wide Mat*.
- **Cinematic Family**: Non-destructive presentation letterboxing for *2.39:1 Anamorphic Scope*, *2.35:1 Widescreen Letterbox*, *2.00:1 Univisium Frame*, and *16:9 Broadcast Matte*.
- **Analog Family**: *Darkroom Print Border* (with hairline keyline), *Vintage Light Leak Edge*, *Cyanotype Deep Margin*, and *Silver Gelatin Border*.
- **Camera & Data Family**: *Technical Exposure Strip*, *Minimalist Social Pill*, *Vintage Quartz Date Stamp* (amber & green LED glows), and *Field Journal Data Margin*.
- **Archive Family**: *Contact Sheet Single Frame*, *Catalog Card Mat*, and *Specimen Archive Border*.
- **Quick Category Filters**: Fast discovery using horizontal category filter chips (`All`, `Instant`, `Film`, `Editorial`, `Cinematic`, `Analog`, `Camera & Data`, `Archive`, `Custom`).
- **Batch Application & Persistent Retention**: Presets applied to single or multi-selected photos are automatically saved to persistent local storage and remembered across sessions without tab-switch resets.

### 🖼️ Fine-Art Mats & Museum Inset Keylines
- **Outer Mat**: Proportional border framing (0.5% to 50%) in any custom color with independent Top / Bottom / Left / Right margin control.
- **Museum Inset Keyline (Fillet)**: Contrasting hairline inner border inset at any distance inside the outer mat with customizable stroke thickness (1px–10px) and dedicated color selection.
- **Vintage Polaroid Format**: Authentic instant-film aesthetic with an elongated bottom chin multiplier ($1.0\times$ to $5.0\times$).
- **Retro Digital Date Stamps**: Authentic quartz-crystal camera timestamp (amber or emerald green LED with luminous bloom) dynamically parsed from EXIF capture dates.


### 📷 Dynamic EXIF Camera Badges
- **Gallery Matte Strip**: Extends the canvas downward with an elegant 2-line technical strip:
  - *Left*: Camera Make & Model, Mounted Lens, and custom Photographer Credit / Signature.
  - *Right*: Exposure Settings (ƒ-number, Shutter Speed, ISO, Focal Length) and Capture Date.
- **Social Glass Pill**: Translucent, rounded floating pill overlay in the bottom-right corner with customizable opacity and font palette.

### 🔲 Contact Sheets, Collages & Tile Slicing
- **⚡ Real-Time Live Canvas Grid**: Defined directly in the Final Export tab—when you enable photo collage mode, your $N \times M$ contact sheet composites live right inside the center editor canvas with dynamic aspect ratio adaptation, responsive columns/rows/gutters, and full zoom/pan support!
- **💾 Persistent Grid Preferences**: Your custom grid dimensions (columns, rows, spacing, and cell fit mode) are saved automatically to persistent local storage and remembered across sessions—never clobbered or reset to defaults.
- **$N \times M$ Contact Sheets**: Combine multiple selected photos into a unified grid collage with configurable cell gutters and *Fit (Letterbox)* vs. *Fill (Center-Crop)* modes.
- **🎛️ Minimized Grid Tools & Overlays**: Equipped with a master toggle that keeps composition tools and slice settings minimized by default. When enabled, it expands to offer:
  - **Multi-Tile Splitter**: Slices panoramas and wide compositions into seamless $N \times M$ tiles for swipeable Instagram carousels and $3 \times 3$ grid profile mosaics.
  - **Composition Grid Overlays**: Rule of Thirds ($3 \times 3$) and custom composition guides with live opacity controls.

### 🏷️ Dynamic Filename Templates & Watermarks
- **Token Engine**: Name exports automatically using `{camera}`, `{lens}`, `{iso}`, `{focal}`, `{aperture}`, `{shutter}`, `{date}`, `{time}`, and `{seq}`.
- **Branding**: Text watermarks with automatic legibility drop-shadows or high-res PNG logo overlays with interactive canvas positioning.

---

## 🔄 Seamless Workflow

<p align="center">
  <img src="docs/images/export-workflow.png" width="46%" alt="Standard Export with Seamless Creative Studio Link" />
</p>
<p align="center">
  <em>Switch between standard batch exporting and creative fine-art styling with one click.</em>
</p>

---

## 🚀 Quick Start

### 1. Download Pre-Built Release
Grab the latest production build for Apple Silicon:
- **macOS Installer**: [`RapidRAW_1.6.4_aarch64.dmg`](./RapidRAW_1.6.4_aarch64.dmg) (29.5 MB)

> *First-time launch on macOS: Right-click `RapidRAW.app` in `/Applications` and select **Open**, or run `xattr -cr /Applications/RapidRAW.app`.*

### 2. Apply the v2 Patch to Upstream RapidRAW
The **v2 Patch** is a clean, single-step patch against upstream RapidRAW:

```bash
# 1. Clone RapidRAW
git clone https://github.com/CyberTimon/RapidRAW.git
cd RapidRAW

# 2. Apply v2 Patch
git apply --ignore-whitespace /path/to/creative-export-borders-and-grids-v2.patch

# 3. Compile
npm ci
npm run tauri -- build --bundles dmg --no-sign
```

Or build automatically using our local script:
```bash
./build-creative-export-borders-and-grids.sh
```

---

## ⌨️ Essential Shortcuts

| Key / Gesture | Context | Action |
| :--- | :--- | :--- |
| <kbd>F</kbd> | Editor View | Toggle **Proof Export Frame** on / off |
| <kbd>Cmd</kbd> / <kbd>Ctrl</kbd> + <kbd>E</kbd> | Anywhere | Open / Toggle Export Panel |
| <kbd>Cmd</kbd> / <kbd>Ctrl</kbd> + Click | Filmstrip | Multi-select individual photos |
| <kbd>Shift</kbd> + Click | Filmstrip | Select contiguous range of photos |
| Click & Drag | Canvas Preview | Reposition watermark interactively |
| Trackpad Pinch / Wheel | Editor Canvas | Smooth zoom in / zoom out |

---

## 📂 Repository Structure

* [`creative-export-borders-and-grids-v2.patch`](./creative-export-borders-and-grids-v2.patch): **v2 Active Patch** — Standalone, single-step patch for the unified editor export studio.
* [`creative-export-borders-and-grids-v1.patch`](./creative-export-borders-and-grids-v1.patch): **v1 Legacy Patch** — Original export tab implementation (retained for compatibility).
* [`RapidRAW_1.6.4_aarch64.dmg`](./RapidRAW_1.6.4_aarch64.dmg): Production release DMG for macOS Apple Silicon.
* [`docs/EXPORT_STUDIO_GUIDE.md`](./docs/EXPORT_STUDIO_GUIDE.md): In-depth technical reference, token definitions, and architecture manual.
* [`docs/images/`](./docs/images/): Visual showcase assets and feature screenshots.

---

## 📄 License & Credits

* **RapidRAW** is created by [Timon Käch (CyberTimon)](https://github.com/CyberTimon) and licensed under the **[GNU Affero General Public License v3 (AGPL-3.0)](https://www.gnu.org/licenses/agpl-3.0)**.
* Creative Export Studio and all patches are distributed under the same **AGPL-3.0** license.
