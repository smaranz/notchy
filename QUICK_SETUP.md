# Quick Setup Guide

## Fastest Way: Use XcodeGen

```bash
# Install xcodegen (one-time setup)
brew install xcodegen

# Generate the project
xcodegen generate

# Open in Xcode
open Notchy.xcodeproj
```

## Alternative: Manual Creation in Xcode

If you prefer not to install xcodegen, create the project manually:

### Step 1: Create New Project
1. Open Xcode
2. **File → New → Project**
3. Choose **macOS → App**
4. Click **Next**
5. Fill in:
   - **Product Name:** `Notchy`
   - **Team:** (your team or None)
   - **Organization Identifier:** `com.notchy`
   - **Interface:** SwiftUI
   - **Language:** Swift
   - Uncheck **Use Core Data**
   - Uncheck **Include Tests**
6. Click **Next**
7. **Save in:** `/Users/sandarshdevappa/smaran/projects/notch`
8. Click **Create**

### Step 2: Add Source Files
1. **Delete** the default files:
   - `ContentView.swift`
   - `NotchyApp.swift`
   - `Assets.xcassets` (optional, we don't use it)

2. **Add our source files:**
   - Right-click on **Notchy** folder in Project Navigator
   - Select **Add Files to "Notchy"...**
   - Navigate to `Sources/Notchy/`
   - Select these folders:
     - `Models`
     - `Managers`
     - `Views`
     - `Widgets`
     - `Utilities`
   - **Important settings:**
     - ✅ **Create groups** (selected)
     - ❌ **Copy items if needed** (UNCHECKED)
     - ✅ **Add to targets: Notchy** (checked)
   - Click **Add**

### Step 3: Configure Project Settings

1. Select **Notchy** project (blue icon) in Navigator
2. Select **Notchy** target
3. **General Tab:**
   - **Minimum Deployments:** macOS 14.6
4. **Build Settings Tab:**
   - Search for "Info.plist"
   - Set **Info.plist File** to: `Sources/Notchy/Info.plist`
   - Set **Generate Info.plist File** to: `NO`
5. **Build Phases Tab:**
   - Expand **Copy Bundle Resources**
   - If `Info.plist` is listed, **remove it** (select and press Delete)
   - Info.plist should NOT be in Copy Bundle Resources

### Step 4: Build and Run

1. Press **⌘R** (or click Run button)
2. The app should build and launch
3. Window will appear in the notch area!

## Troubleshooting

### Build Errors
- **Clean Build Folder:** ⌘⇧K, then rebuild ⌘B
- **Check all files are added to target:** Select file → File Inspector → Target Membership → ✅ Notchy
- **Verify Info.plist path:** Build Settings → Info.plist File

### App Doesn't Appear
- Check Console.app for errors
- Ensure macOS 14.6+ is running
- Verify window positioning code is running

### Still Having Issues?
See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for more help.

