# Create New Xcode Project

## Method 1: Quick Setup (Recommended)

Since automated project generation has issues, here's the fastest way to create the project:

### In Xcode:

1. **Open Xcode**

2. **Create New Project:**
   - File → New → Project (⌘⇧N)
   - Choose **macOS** → **App**
   - Click **Next**

3. **Configure Project:**
   - Product Name: `Notchy`
   - Team: (select your team or None)
   - Organization Identifier: `com.notchy`
   - Bundle Identifier: `com.notchy.Notchy` (auto-filled)
   - Interface: **SwiftUI**
   - Language: **Swift**
   - ☐ Uncheck "Use Core Data"
   - ☐ Uncheck "Include Tests"
   - Click **Next**

4. **Save Location:**
   - Navigate to: `/Users/sandarshdevappa/smaran/projects/notch`
   - **Important:** Make sure "Create Git repository" is UNCHECKED (we already have git)
   - Click **Create**

5. **Delete Default Files:**
   - In Project Navigator, delete:
     - `ContentView.swift`
     - `NotchyApp.swift`
   - Right-click → Move to Trash

6. **Add Source Files:**
   - Right-click on **Notchy** folder (blue folder icon)
   - Select **Add Files to "Notchy"...**
   - Navigate to `Sources/Notchy/`
   - Select these **folders** (not individual files):
     - `Models`
     - `Managers`  
     - `Views`
     - `Widgets`
     - `Utilities`
   - **Settings:**
     - ✅ **Create groups** (selected)
     - ❌ **Copy items if needed** (UNCHECKED - very important!)
     - ✅ **Add to targets: Notchy** (checked)
   - Click **Add**

7. **Add Info.plist:**
   - Right-click on **Notchy** folder again
   - **Add Files to "Notchy"...**
   - Navigate to `Sources/Notchy/`
   - Select `Info.plist`
   - Same settings as above
   - Click **Add**

8. **Configure Build Settings:**
   - Select **Notchy** project (blue icon at top)
   - Select **Notchy** target
   - **General Tab:**
     - Minimum Deployments: **macOS 14.6**
   - **Build Settings Tab:**
     - Search for "Info.plist"
     - **Info.plist File:** Set to `Sources/Notchy/Info.plist`
     - **Generate Info.plist File:** Set to **NO**
   - **Build Phases Tab:**
     - Expand **Copy Bundle Resources**
     - If `Info.plist` appears here, **select it and delete it** (press Delete key)
     - Info.plist should NOT be in Copy Bundle Resources

9. **Build and Run:**
   - Press **⌘R** (or Product → Run)
   - The app should build and launch!

## Method 2: Using project.yml (if xcodegen is available)

If you have xcodegen installed:

```bash
brew install xcodegen  # if not installed
xcodegen generate
open Notchy.xcodeproj
```

## Verification Checklist

After creating the project, verify:

- [ ] All source files are visible in Project Navigator
- [ ] Files are organized in groups (Models, Views, etc.)
- [ ] Info.plist is in Sources/Notchy/ group
- [ ] Info.plist is NOT in Copy Bundle Resources
- [ ] Build Settings → Info.plist File = `Sources/Notchy/Info.plist`
- [ ] Build Settings → Generate Info.plist File = NO
- [ ] Minimum Deployment = macOS 14.6
- [ ] Project builds without errors (⌘B)

## Common Issues

### "Cannot find type 'X' in scope"
- Make sure all files are added to the target
- Select file → File Inspector → Target Membership → ✅ Notchy

### "Multiple commands produce" error
- Info.plist is in Copy Bundle Resources - remove it!
- See Build Phases → Copy Bundle Resources

### Project won't build
- Clean: ⌘⇧K
- Delete DerivedData: `rm -rf ~/Library/Developer/Xcode/DerivedData/Notchy-*`
- Rebuild: ⌘B

## Need Help?

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for more detailed help.

