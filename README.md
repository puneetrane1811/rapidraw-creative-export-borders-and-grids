# RapidRAW - Export Image Borders Patch

This directory contains the custom patch and automated build tools to add an **Export Image Borders** feature to [RapidRAW](https://github.com/CyberTimon/RapidRAW).

---

## 📌 Feature Overview

This modification brings an ImageMagick-style border capability (`magick "$file" -border 1%x1% "border_${file}"`) directly into RapidRAW's native export workflow:
- **Toggle switch**: Enable/disable borders on export (`Add Border`).
- **Adjustable thickness**: Slider from `0.1%` to `20.0%` of image dimensions (default: `1.0%`).
- **Color picker**: Native RGB color picker (default: `#ffffff` white).
- **Preset integration**: Border configurations persist across custom export presets and default presets.
- **Full pipeline compatibility**: Seamlessly integrates with single-image exports, batch exports, resizing, and watermarking.

---

## 📂 Included Files

| File | Description |
| :--- | :--- |
| [`export-borders.patch`](./export-borders.patch) | Standard unified diff patch modifying Rust backend and React frontend. |
| [`update-and-build.sh`](./update-and-build.sh) | One-command shell script to fetch any new RapidRAW release, apply the patch, and build the macOS `.dmg`. |
| [`RapidRAW_1.6.3_aarch64.dmg`](./RapidRAW_1.6.3_aarch64.dmg) | Ready-to-install Apple Silicon macOS installer containing this feature. |

---

## 🛠️ Modified Source Files in the Patch

The patch touches 7 files cleanly across the codebase:

1. **`src-tauri/src/export_processing.rs`**:
   - Defines `BorderSettings` struct (`size: f32`, `color: String`).
   - Implements `parse_border_color` (hex color parsing to `Rgba<u8>`).
   - Implements `border_dimensions` (percentage calculation with integer overflow safety).
   - Implements `apply_border` (overlaying image onto padded background canvas).
   - Updates `determine_export_dimensions` so exported metadata and pixel ratios reflect the border.
2. **`src-tauri/src/app_settings.rs`**:
   - Adds `enable_border`, `border_size`, and `border_color` to `ExportPreset` serialization.
3. **`src/components/panel/right/ExportPanel.tsx`**:
   - Adds the "Border" section in the right-hand export sidebar.
   - Includes toggle switch, percentage slider, and color picker.
   - Passes `border` payload to both single and batch export routines.
4. **`src/hooks/useExportSettings.ts`**:
   - Manages state hooks and preset synchronization.
5. **`src/components/ui/ExportImportProperties.tsx`**:
   - Updates TypeScript interfaces for preset properties and export states.
6. **`src/hooks/useExternalEditSession.ts`**:
   - Initializes `border: null` in external edit sessions.
7. **`src/i18n/locales/en.json`**:
   - Adds localization strings for `export.border.*`.

---

## 🚀 How to Apply the Patch

### Option A: Using the Automated Script (Quickest)

If you have the workspace toolchain in place:

```bash
cd /path/to/so-x20/outputs

# Rebuild against latest main branch:
./update-and-build.sh

# Or rebuild against a specific release tag (e.g., v1.7.0):
./update-and-build.sh v1.7.0
```

The script will fetch the release source, apply `export-borders.patch`, run the build, and place the new `.dmg` in this folder.

---

### Option B: Applying Manually to a Git Clone

1. **Clone RapidRAW**:
   ```bash
   git clone https://github.com/CyberTimon/RapidRAW.git
   cd RapidRAW
   ```

2. **Check out the target release or branch**:
   ```bash
   git checkout v1.7.0   # or your desired version
   ```

3. **Apply the patch**:
   ```bash
   git apply /path/to/export-borders.patch
   ```
   *(Alternative using standard patch tool: `patch -p1 < /path/to/export-borders.patch`)*

4. **Verify changes**:
   ```bash
   git status
   git diff
   ```

5. **Build the macOS DMG**:
   ```bash
   npm ci
   npm run tauri -- build --bundles dmg --no-sign
   ```
   The resulting installer will be located in:
   `src-tauri/target/release/bundle/dmg/RapidRAW_<version>_aarch64.dmg`

---

### Option C: Personal GitHub Fork (Cloud Rebuild)

1. Fork `https://github.com/CyberTimon/RapidRAW` to your GitHub account.
2. Create a custom branch:
   ```bash
   git checkout -b custom-borders
   git apply export-borders.patch
   git commit -am "feat: export image borders"
   git push origin custom-borders
   ```
3. Whenever a new RapidRAW release is published, sync your fork or rebase `custom-borders` on top of the new release tag. RapidRAW's GitHub Actions workflow will automatically build and publish the `.dmg` in your repository's **Actions** tab.

---

### Option D: Automated Windows (.exe) Cloud Build

This repository includes a GitHub Actions workflow to build native Windows installers (`.exe`) directly in the cloud:

1. Go to your repository on GitHub and click the **Actions** tab.
2. Under All workflows, select **Build Windows Release (.exe)**.
3. Click the **Run workflow** dropdown button:
   - **RapidRAW Release Tag**: Choose the version (default: `main`).
   - **Attach to an existing GitHub Release**: Checked by default.
   - **GitHub Release Tag**: `v1.6.3-borders`
4. Click **Run workflow**.

GitHub's Windows runner will automatically check out RapidRAW, apply `export-borders.patch`, compile the NSIS installer (`.exe`), and attach it to your release or provide it as a downloadable artifact!

---

### Option E: Continuous Auto-Rebuild on Upstream Release (Zero-Maintenance)

The workflow [`.github/workflows/auto-release.yml`](./.github/workflows/auto-release.yml) runs automatically on a **daily schedule**:
1. Checks [CyberTimon/RapidRAW](https://github.com/CyberTimon/RapidRAW) for any new tagged release.
2. Compiles both **macOS (`.dmg`)** and **Windows (`.exe`)** in parallel on GitHub runners.
3. Automatically publishes a new release under your repository's Releases page with both installer binaries attached.

You can also trigger it on demand anytime from the **Actions** tab under **Auto Rebuild on Upstream Release**.



---

## 🍏 Installing on macOS (Gatekeeper Bypass)

Because local or personal builds are unsigned, macOS Gatekeeper may block the app on first launch.

After dragging `RapidRAW.app` into `/Applications`:
- **Finder**: Right-click (or <kbd>Control</kbd>-click) `RapidRAW.app`, select **Open**, and click **Open** on the confirmation prompt.
- **Terminal**: Run:
  ```bash
  xattr -cr /Applications/RapidRAW.app
  ```

---

## ⚠️ Troubleshooting Future Conflicts

If RapidRAW significantly refactors the export panel in a future update, `git apply` may fail with a conflict. To resolve:
1. Run `git apply --reject export-borders.patch` (this applies matching parts and writes `.rej` files for conflicting hunks).
2. Open the `.rej` file to see what lines couldn't be automatically placed.
3. Manually place the border UI in `ExportPanel.tsx` or processing call in `export_processing.rs`.
