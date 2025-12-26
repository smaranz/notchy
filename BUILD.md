# Building Notchy

## Prerequisites

- macOS 14.6 or later
- Xcode 15.0 or later
- Swift 5.9 or later

## Building with Xcode

1. Open Terminal and navigate to the project directory:
```bash
cd /path/to/notch
```

2. Create an Xcode project:
```bash
# If you have Xcode installed, you can create a project manually:
# 1. Open Xcode
# 2. File > New > Project
# 3. Choose "macOS" > "App"
# 4. Set Product Name to "Notchy"
# 5. Set Interface to "SwiftUI"
# 6. Set Language to "Swift"
# 7. Save in the project directory
# 8. Add all files from Sources/Notchy to the project
```

## Building with Swift Package Manager

Since this is a macOS app, you'll need to create an Xcode project. However, you can use Swift Package Manager to verify the code compiles:

```bash
swift build
```

## Running the App

1. Build the project in Xcode (⌘B)
2. Run the app (⌘R)
3. The app will automatically position itself in the notch area

## Troubleshooting

### Window doesn't appear
- Check that you're running macOS 14.6 or later
- Ensure the app has proper permissions
- Check Console.app for any error messages

### Widgets not showing
- Check Settings to ensure widgets are enabled
- Verify widget registry is loading properly

### Media controls not working
- Ensure you have media playing (Spotify, Apple Music, etc.)
- Check that the app has proper media permissions

### File shelf not accepting drops
- Ensure you're dragging files from Finder
- Check file permissions

## Notes

- The app requires macOS 14.6+ for the `safeAreaInsets` API
- On notchless screens, the app will appear as a handler bar at the top
- The app runs in the background and doesn't appear in the Dock by default
