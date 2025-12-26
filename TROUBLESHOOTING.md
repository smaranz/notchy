# Troubleshooting Build Issues

## Project Won't Open

If you're getting "damaged project" or JSON parsing errors:

### Solution 1: Create Project Manually (Recommended)

Run the helper script:
```bash
./create_project_simple.sh
```

This will give you step-by-step instructions to create the project in Xcode manually.

### Solution 2: Use XcodeGen

If you have `xcodegen` installed:
```bash
brew install xcodegen
xcodegen generate
open NotchNook.xcodeproj
```

### Solution 3: Regenerate Project

Try regenerating the project:
```bash
rm -rf NotchNook.xcodeproj
python3 generate_xcode_project.py
```

Then try opening in Xcode GUI (not command line):
```bash
open NotchNook.xcodeproj
```

## Common Build Errors

### "No such module 'SwiftUI'"
- Make sure you're building for macOS, not iOS
- Check deployment target is macOS 14.6+

### "Cannot find type 'WindowManager' in scope"
- Make sure all source files are added to the target
- Check that files are in the correct groups in Xcode

### "Info.plist not found"
- In Build Settings, set "Info.plist File" to: `Sources/NotchNook/Info.plist`
- Or copy Info.plist to the project root

### Signing Errors
- Go to Signing & Capabilities
- Check "Automatically manage signing"
- Select your Team (or None for local development)

### Window Doesn't Appear
- Check Console.app for errors
- Ensure macOS 14.6+ is running
- Check that the app has proper permissions

## Manual Project Creation Steps

1. **Create New Project in Xcode**
   - macOS → App
   - SwiftUI interface
   - Swift language

2. **Add Source Files**
   - Drag `Sources/NotchNook` folder into Xcode
   - Choose "Create groups" (not folder references)
   - Uncheck "Copy items if needed"

3. **Configure Build Settings**
   - Minimum Deployment: macOS 14.6
   - Info.plist path: `Sources/NotchNook/Info.plist`

4. **Remove Default Files**
   - Delete default `ContentView.swift` and `NotchNookApp.swift`
   - Use the ones from `Sources/NotchNook/`

5. **Build and Run**
   - Press ⌘R
   - The app should launch and position in the notch area

## Still Having Issues?

1. Check Xcode version (need 15.0+)
2. Check macOS version (need 14.6+)
3. Try cleaning build folder (⌘⇧K)
4. Try deleting DerivedData
5. Check Console.app for runtime errors

