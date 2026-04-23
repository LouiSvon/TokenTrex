#!/bin/bash
set -e

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
APP_DIR="$PROJECT_DIR/build/TokenTrex.app"

echo "Building TokenTrex..."

# Xcode.app is required — Xcode Command Line Tools alone lack the macOS SDK
# frameworks (SwiftUI, AppKit, Combine) needed for GUI apps.
if [ ! -d "/Applications/Xcode.app/Contents/Developer" ]; then
    echo "Error: Xcode.app is required to build TokenTrex."
    echo ""
    echo "The Xcode Command Line Tools don't include the macOS SDK frameworks"
    echo "(SwiftUI, AppKit) needed for GUI apps. Install Xcode from the App Store:"
    echo "  https://apps.apple.com/app/xcode/id497799835"
    echo ""
    echo "After installing, run:"
    echo "  sudo xcode-select -s /Applications/Xcode.app/Contents/Developer"
    exit 1
fi

DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer \
    swift build --package-path "$PROJECT_DIR"

# Create .app bundle
mkdir -p "$APP_DIR/Contents/MacOS"
mkdir -p "$APP_DIR/Contents/Resources"

cp "$PROJECT_DIR/.build/debug/TokenTrex" "$APP_DIR/Contents/MacOS/TokenTrex"
cp "$PROJECT_DIR/TokenTrex/Info.plist" "$APP_DIR/Contents/Info.plist"
cp "$PROJECT_DIR/TokenTrex/Assets.xcassets/AppIcon.icns" "$APP_DIR/Contents/Resources/AppIcon.icns"

echo "Build complete: $APP_DIR"
echo ""
echo "To run:  open $APP_DIR"
echo "To kill: pkill -f TokenTrex"
