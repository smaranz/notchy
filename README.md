# NotchNook - Free macOS Notch Utility

A free, open-source macOS application that transforms your MacBook's notch area into a powerful utility hub with widgets, file management, live actions, and gesture support.

## Features

- **Widgets**: Clock, Calendar, System Info, and Media Controls
- **File Shelf**: Quick access to pinned files and folders with drag & drop support
- **Live Actions**: Media controls, system actions, and quick app launcher
- **Gesture Support**: Swipe to scroll through widgets, tap to interact
- **Multi-Monitor Support**: Works across all connected displays
- **Notchless Screen Support**: Transforms into a handler bar on screens without a notch

## Requirements

- macOS 14.6 or later
- Xcode 15.0 or later (for building from source)
- Swift 5.9 or later

## Building from Source

### Quick Start - Create New Project

**The most reliable way is to create the project manually in Xcode:**

See **[CREATE_PROJECT.md](CREATE_PROJECT.md)** for detailed step-by-step instructions.

**Quick version:**
1. Open Xcode → File → New → Project
2. Choose macOS → App → SwiftUI → Swift
3. Product Name: `NotchNook`, Organization: `com.notchnook`
4. Save in this directory
5. Delete default ContentView.swift and NotchNookApp.swift
6. Add all folders from `Sources/NotchNook/` to the project
7. Configure: Minimum Deployment = macOS 14.6, Info.plist path = `Sources/NotchNook/Info.plist`
8. Build and run with ⌘R

For complete instructions, see [CREATE_PROJECT.md](CREATE_PROJECT.md).

### Alternative: Generate Project Manually

If you need to regenerate the project:

**Option 1: Using Python script (Recommended)**
```bash
python3 generate_xcode_project.py
open NotchNook.xcodeproj
```

**Option 2: Using xcodegen**
```bash
# Install xcodegen first: brew install xcodegen
./create_project.sh
open NotchNook.xcodeproj
```

**Option 3: Manual Setup in Xcode**

1. Open Xcode (version 15.0 or later)
2. File → New → Project
3. Choose "macOS" → "App"
4. Product Name: `NotchNook`
5. Interface: `SwiftUI`
6. Language: `Swift`
7. Save in this directory
8. Add all files from `Sources/NotchNook/` to the project
9. Set minimum deployment to macOS 14.6
10. Build and run (⌘R)

## Installation

### Option 1: Build from Source
Follow the "Building from Source" instructions above.

### Option 2: Download Release (when available)
Download the latest release from the Releases page and drag the app to your Applications folder.

## Usage

1. Launch NotchNook from Applications
2. The app will automatically position itself in the notch area (or as a handler on notchless screens)
3. Swipe horizontally to scroll through widgets
4. Drag files from Finder onto the file shelf for quick access
5. Use live action buttons for quick system actions
6. Right-click or access Settings to customize widgets and appearance

## Configuration

Access settings by:
- Right-clicking on the notch area
- Using the Settings menu item
- Or pressing ⌘, (Command + Comma)

## Privacy

NotchNook runs entirely locally on your Mac. No data is collected, transmitted, or stored externally. All settings and file references are stored locally using macOS UserDefaults.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and free to use. See LICENSE file for details.

## Acknowledgments

Inspired by NotchNook by lo.cafe. This is a free, open-source alternative.

