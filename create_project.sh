#!/bin/bash

# Script to create Xcode project for NotchNook
# This script uses xcodegen if available, or provides instructions

set -e

PROJECT_NAME="Notchy"

echo "Creating Xcode project for $PROJECT_NAME..."

# Check if xcodegen is installed
if command -v xcodegen &> /dev/null; then
    echo "Using xcodegen to create project..."
    xcodegen generate
    echo ""
    echo "✅ Xcode project created successfully!"
    echo ""
    echo "To open the project:"
    echo "  open $PROJECT_NAME.xcodeproj"
else
    echo "⚠️  xcodegen is not installed."
    echo ""
    echo "To install xcodegen:"
    echo "  brew install xcodegen"
    echo ""
    echo "Or create the project manually in Xcode:"
    echo "  1. Open Xcode"
    echo "  2. File → New → Project"
    echo "  3. Choose 'macOS' → 'App'"
    echo "  4. Product Name: Notchy"
    echo "  5. Interface: SwiftUI"
    echo "  6. Language: Swift"
    echo "  7. Add all files from Sources/NotchNook/"
    echo "  8. Set minimum deployment to macOS 14.6"
    echo ""
    echo "Alternatively, you can use the setup_xcode_project.sh script"
    echo "to create a basic project structure."
fi
