# Opening/Creating the Project

## If Project Already Exists

```bash
open NotchNook.xcodeproj
```

## If Project Doesn't Exist Yet

I've opened Xcode in this directory. Now follow these steps:

### Quick Steps:

1. **In Xcode** (which should now be open):
   - File → New → Project (⌘⇧N)
   - Choose **macOS** → **App**
   - Click **Next**

2. **Fill in:**
   - Product Name: `NotchNook`
   - Organization Identifier: `com.notchnook`
   - Interface: **SwiftUI**
   - Language: **Swift**
   - Uncheck Core Data and Tests
   - Click **Next**

3. **Save:**
   - Make sure you're saving in: `/Users/sandarshdevappa/smaran/projects/notch`
   - Uncheck "Create Git repository"
   - Click **Create**

4. **Add Files:**
   - Delete default `ContentView.swift` and `NotchNookApp.swift`
   - Right-click **NotchNook** folder → **Add Files to "NotchNook"...**
   - Select all folders from `Sources/NotchNook/`: Models, Managers, Views, Widgets, Utilities
   - Also add `Info.plist` from `Sources/NotchNook/`
   - Settings: Create groups ✅, Copy items ❌, Add to targets ✅

5. **Configure:**
   - Project → Target → General: Minimum Deployment = macOS 14.6
   - Build Settings → Info.plist File = `Sources/NotchNook/Info.plist`
   - Build Settings → Generate Info.plist = NO
   - Build Phases → Remove Info.plist from Copy Bundle Resources if present

6. **Build:** ⌘R

For detailed instructions, see [CREATE_PROJECT.md](CREATE_PROJECT.md)

