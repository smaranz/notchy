# Fixing Build Errors

## "Multiple commands produce" Error

This error occurs when the same file is being processed multiple times. Common causes:

### Fix 1: Remove Info.plist from Copy Bundle Resources

1. Open project in Xcode
2. Select the **NotchNook** project (blue icon)
3. Select the **NotchNook** target
4. Go to **Build Phases** tab
5. Expand **Copy Bundle Resources**
6. If you see `Info.plist` listed, select it and press Delete
7. Info.plist should NOT be in Copy Bundle Resources - it's processed automatically

### Fix 2: Check for Duplicate Files

1. In Xcode, search for files (⌘⇧F)
2. Search for "Info.plist"
3. Make sure there's only ONE Info.plist reference
4. If duplicates exist, remove them from the project

### Fix 3: Clean Build Folder

1. In Xcode: **Product → Clean Build Folder** (⌘⇧K)
2. Close Xcode
3. Delete DerivedData:
   ```bash
   rm -rf ~/Library/Developer/Xcode/DerivedData/NotchNook-*
   ```
4. Reopen project and build again

### Fix 4: Verify Build Settings

1. Select **NotchNook** target
2. Go to **Build Settings**
3. Search for "Info.plist"
4. Verify:
   - **Info.plist File** = `Sources/NotchNook/Info.plist`
   - **Generate Info.plist File** = NO

## Other Common Errors

### "Cannot find type 'X' in scope"
- Make sure all Swift files are added to the target
- Check that files are in the correct groups
- Clean and rebuild

### "No such module 'SwiftUI'"
- Verify you're building for macOS (not iOS)
- Check deployment target is macOS 14.6+

### Signing Errors
- Go to **Signing & Capabilities**
- Check **Automatically manage signing**
- Select your Team (or None for local dev)

## Quick Fix Script

Run this to clean everything:
```bash
# Clean DerivedData
rm -rf ~/Library/Developer/Xcode/DerivedData/NotchNook-*

# Clean build folder in Xcode (⌘⇧K)
# Then rebuild (⌘B)
```

