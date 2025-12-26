#!/usr/bin/env bash
set -euo pipefail

APP_NAME=$(/usr/libexec/PlistBuddy -c "Print :CFBundleDisplayName" "Sources/Notchy/Info.plist" 2>/dev/null || echo "Notchy")
DERIVED_DATA_PATH="build"
DIST_DIR="dist"
PROJECT_PATH=$(ls -1 *.xcodeproj 2>/dev/null | head -n 1 || true)

if [ -z "$PROJECT_PATH" ]; then
  echo "No .xcodeproj found."
  echo "Create one with:"
  echo "  python3 generate_xcode_project.py"
  echo "or:"
  echo "  brew install xcodegen && xcodegen generate"
  exit 1
fi

SCHEME_NAME=$(/usr/bin/xcodebuild -list -project "$PROJECT_PATH" | awk '/Schemes:/{flag=1;next}/^$/{flag=0}flag{print;exit}' | xargs)
if [ -z "$SCHEME_NAME" ]; then
  echo "No schemes found in $PROJECT_PATH"
  exit 1
fi

echo "Building unsigned release..."
xcodebuild \
  -project "$PROJECT_PATH" \
  -scheme "$SCHEME_NAME" \
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

VERSION=$(/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" "Sources/Notchy/Info.plist" 2>/dev/null || echo "0.0.0")

mkdir -p "$DIST_DIR"
ZIP_NAME="$DIST_DIR/$APP_NAME-$VERSION.zip"
rm -f "$ZIP_NAME"

echo "Creating release zip: $ZIP_NAME"
ditto -c -k --sequesterRsrc --keepParent "$APP_PATH" "$ZIP_NAME"

echo "Done: $ZIP_NAME"
