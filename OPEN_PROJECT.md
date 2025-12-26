# Opening/Creating the Project

## If Project Already Exists

```bash
open Notchy.xcodeproj
```

## If Project Doesn't Exist Yet

I've opened Xcode in this directory. Now follow these steps:

### Quick Steps:

1. **In Xcode** (which should now be open):
   - File → New → Project (⌘⇧N)
   - Choose **macOS** → **App**
   - Click **Next**

2. **Fill in:**
   - Product Name: `Notchy`
   - Organization Identifier: `com.notchy`
   - Interface: **SwiftUI**
   - Language: **Swift**
   - Uncheck Core Data and Tests
   - Click **Next**

3. **Save:**
   - Make sure you're saving in: `/Users/sandarshdevappa/smaran/projects/notch`
   - Uncheck "Create Git repository"
   - Click **Create**

4. **Add Files:**
   - Delete default `ContentView.swift` and `NotchyApp.swift`
   - Right-click **Notchy** folder → **Add Files to "Notchy"...**
   - Select all folders from `Sources/Notchy/`: Models, Managers, Views, Widgets, Utilities
   - Also add `Info.plist` from `Sources/Notchy/`
   - Settings: Create groups ✅, Copy items ❌, Add to targets ✅

5. **Configure:**
   - Project → Target → General: Minimum Deployment = macOS 14.6
   - Build Settings → Info.plist File = `Sources/Notchy/Info.plist`
   - Build Settings → Generate Info.plist = NO
   - Build Phases → Remove Info.plist from Copy Bundle Resources if present

6. **Build:** ⌘R

For detailed instructions, see [CREATE_PROJECT.md](CREATE_PROJECT.md)

