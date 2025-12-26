# Quick Start Guide

## 🚀 Getting Started

The Xcode project is already created and ready to use!

### Step 1: Open the Project

```bash
open Notchy.xcodeproj
```

### Step 2: Build and Run

1. In Xcode, press **⌘R** (or click the Run button)
2. The app will compile and launch
3. The window will automatically position itself in the notch area

### Step 3: Configure Signing (First Time Only)

If you see signing errors:

1. Select the **Notchy** project in the navigator
2. Select the **Notchy** target
3. Go to **Signing & Capabilities** tab
4. Check **"Automatically manage signing"**
5. Select your **Team** (or create a free Apple ID if needed)

### Step 4: Enjoy!

The app will:
- Position itself in the notch area (or as a handler bar on notchless screens)
- Show widgets (Clock, Calendar, System Info, Media Controls)
- Allow you to drag files to the file shelf
- Provide quick actions (screenshot, media controls)

## 🛠️ Troubleshooting

### Project won't open
- Make sure you have Xcode 15.0 or later installed
- Try regenerating: `python3 generate_xcode_project.py`

### Build errors
- Make sure all files are included in the project
- Check that minimum deployment is set to macOS 14.6
- Clean build folder: **⌘⇧K**, then rebuild: **⌘B**

### App doesn't appear
- Check Console.app for error messages
- Ensure you're running macOS 14.6 or later
- Verify the app has proper permissions

### Widgets not showing
- Open Settings (⌘,) and check widget visibility toggles
- Restart the app

## 📝 Next Steps

- Customize widgets in Settings
- Add files to the file shelf by dragging from Finder
- Adjust transparency and appearance preferences
- Explore gesture controls (swipe to scroll widgets)

## 🎯 Features

✅ Window positioning in notch area  
✅ Clock widget with real-time updates  
✅ Calendar widget  
✅ System info (CPU, Memory, Battery)  
✅ Media controls  
✅ File shelf with drag & drop  
✅ Quick actions (screenshot, etc.)  
✅ Gesture support  
✅ Settings panel  
✅ Multi-monitor support  

Enjoy your new Notchy app! 🎉

