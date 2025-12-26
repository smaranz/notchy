#!/usr/bin/env bash
set -euo pipefail

APP_NAME="Notchy"
DERIVED_DATA_PATH="build"
DIST_DIR="dist"

if ! command -v xcodegen >/dev/null 2>&1; then
  echo "xcodegen is required. Install it with: brew install xcodegen"
  exit 1
fi

echo "Generating Xcode project..."
xcodegen generate

echo "Building unsigned release..."
xcodebuild \
  -scheme "$APP_NAME" \
  -configuration Release \
  -derivedDataPath "$DERIVED_DATA_PATH" \
  CODE_SIGNING_ALLOWED=NO \
  CODE_SIGN_IDENTITY="" \
  build

APP_PATH="$DERIVED_DATA_PATH/Build/Products/Release/$APP_NAME.app"
if [ ! -d "$APP_PATH" ]; then
  echo "Build failed: $APP_PATH not found"
  exit 1
fi

VERSION=$(/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" "Sources/NotchNook/Info.plist" 2>/dev/null || echo "0.0.0")

mkdir -p "$DIST_DIR"
ZIP_NAME="$DIST_DIR/$APP_NAME-$VERSION.zip"
rm -f "$ZIP_NAME"

echo "Creating release zip: $ZIP_NAME"
ditto -c -k --sequesterRsrc --keepParent "$APP_PATH" "$ZIP_NAME"

echo "Done: $ZIP_NAME"
