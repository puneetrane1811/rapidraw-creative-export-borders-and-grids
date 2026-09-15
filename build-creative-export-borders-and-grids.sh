#!/usr/bin/env bash
set -euo pipefail

# Default to latest main if no branch/tag is provided
TARGET_REF="${1:-main}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(dirname "$SCRIPT_DIR")"
WORK_DIR="$BASE_DIR/work"
BUILD_DIR="$BASE_DIR/build_temp"
PATCH_FILE="$SCRIPT_DIR/creative-export-borders-and-grids.patch"

echo "=== RapidRAW Creative Export Borders & Grids Builder ==="
echo "Target ref: $TARGET_REF"
echo "Patch file: $PATCH_FILE"

# 1. Prepare clean source
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

echo "--> Fetching RapidRAW source ($TARGET_REF)..."
curl -fL --silent --show-error "https://github.com/CyberTimon/RapidRAW/archive/refs/heads/${TARGET_REF}.zip" -o "$BUILD_DIR/source.zip" \
  || curl -fL --silent --show-error "https://github.com/CyberTimon/RapidRAW/archive/refs/tags/${TARGET_REF}.zip" -o "$BUILD_DIR/source.zip"

unzip -q "$BUILD_DIR/source.zip" -d "$BUILD_DIR"
SRC_DIR=$(find "$BUILD_DIR" -maxdepth 1 -type d -name "RapidRAW-*" | head -n 1)

# 2. Apply patch
echo "--> Applying creative-export-borders-and-grids.patch..."
cd "$SRC_DIR"
patch -p1 < "$PATCH_FILE"

# 3. Reuse isolated toolchains and ONNX libraries
export PATH="$WORK_DIR/toolchains/node/bin:$WORK_DIR/toolchains/cargo/bin:$PATH"
export CARGO_HOME="$WORK_DIR/toolchains/cargo"
export RUSTUP_HOME="$WORK_DIR/toolchains/rustup"
export npm_config_cache="$WORK_DIR/toolchains/npm-cache"

# Copy cached onnxruntime lib if available to avoid redownloading
if [ -f "$WORK_DIR/RapidRAW/src-tauri/resources/libonnxruntime.dylib" ]; then
  mkdir -p "$SRC_DIR/src-tauri/resources"
  cp "$WORK_DIR/RapidRAW/src-tauri/resources/libonnxruntime.dylib" "$SRC_DIR/src-tauri/resources/"
fi
export ORT_LIB_LOCATION="$SRC_DIR/src-tauri/resources"

# 4. Install npm dependencies and build
echo "--> Installing dependencies..."
npm ci

echo "--> Building macOS DMG..."
npm run tauri -- build --bundles dmg --no-sign

# 5. Copy output
DMG_FILE=$(find "$SRC_DIR/src-tauri/target/release/bundle/dmg" -name "*.dmg" | head -n 1)
if [ -n "$DMG_FILE" ]; then
  cp "$DMG_FILE" "$SCRIPT_DIR/"
  echo "=== SUCCESS! ==="
  echo "New DMG generated at: $SCRIPT_DIR/$(basename "$DMG_FILE")"
fi

rm -rf "$BUILD_DIR"
