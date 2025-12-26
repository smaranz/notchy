# 🚀 START HERE - Create Project in Xcode

The automated project generation had issues. **Creating the project manually in Xcode is the most reliable method** and only takes 2 minutes.

## Step-by-Step Instructions

### 1. Create New Project (Xcode should be open now)

1. In Xcode: **File → New → Project** (⌘⇧N)
2. **⚠️ IMPORTANT:** Choose **macOS** → **App** (NOT iOS!)
3. Click **Next**

### 2. Configure Project

Fill in these fields:
- **Product Name:** `Notchy`
- **Team:** (select your team or "None")
- **Organization Identifier:** `com.notchy`
- **Bundle Identifier:** (auto-filled as `com.notchy.Notchy`)
- **Interface:** **SwiftUI** ⚠️ Important!
- **Language:** **Swift** ⚠️ Important!
- **☐ Use Core Data** (UNCHECK this)
- **☐ Include Tests** (UNCHECK this)

Click **Next**

### 3. Save Location

- Navigate to: `/Users/sandarshdevappa/smaran/projects/notch`
- **⚠️ IMPORTANT:** Uncheck **"Create Git repository"** (we already have git)
- Click **Create**

### 4. Delete Default Files

In the Project Navigator (left sidebar):
- Select `ContentView.swift` → Right-click → **Move to Trash**
- Select `NotchyApp.swift` → Right-click → **Move to Trash**

### 5. Add Source Files

1. Right-click on the **Notchy** folder (blue folder icon) in Project Navigator
2. Select **"Add Files to 'Notchy'..."**
3. Navigate to `Sources/Notchy/` folder
4. Select these **FOLDERS** (click on folder names, not individual files):
   - ✅ `Models`
   - ✅ `Managers`
   - ✅ `Views`
   - ✅ `Widgets`
   - ✅ `Utilities`
5. **CRITICAL SETTINGS:**
   - ✅ **"Create groups"** (selected)
   - ❌ **"Copy items if needed"** (UNCHECKED - very important!)
   - ✅ **"Add to targets: Notchy"** (checked)
6. Click **Add**

### 6. Add Info.plist

1. Right-click on **Notchy** folder again
2. **"Add Files to 'Notchy'..."**
3. Navigate to `Sources/Notchy/`
4. Select `Info.plist`
5. Same settings: Create groups ✅, Copy items ❌, Add to targets ✅
6. Click **Add**

### 7. Configure Build Settings

1. Click on **Notchy** project (blue icon at top of Navigator)
2. Select **Notchy** target (under TARGETS)
3. **General Tab:**
   - **Minimum Deployments:** Change to **macOS 14.6**
4. **Build Settings Tab:**
   - Search for "Info.plist" in the search box
   - Find **"Info.plist File"** setting
   - Double-click the value and change it to: `Sources/Notchy/Info.plist`
   - Find **"Generate Info.plist File"** setting
   - Set it to **NO**
5. **Build Phases Tab:**
   - Expand **"Copy Bundle Resources"**
   - If you see `Info.plist` listed here, **select it and press Delete**
   - Info.plist should NOT be in Copy Bundle Resources

### 8. Build and Run! 🎉

Press **⌘R** (or click the Play button)

The app should build and launch, positioning itself in the notch area!

---

## ✅ Verification Checklist

After setup, verify:
- [ ] All source files visible in Project Navigator
- [ ] Files organized in groups (Models, Views, etc.)
- [ ] Info.plist in Sources/Notchy group
- [ ] Info.plist NOT in Copy Bundle Resources
- [ ] Build Settings → Info.plist File = `Sources/Notchy/Info.plist`
- [ ] Build Settings → Generate Info.plist = NO
- [ ] Minimum Deployment = macOS 14.6
- [ ] Project builds successfully (⌘B)

## 🆘 Need Help?

If you encounter errors:
- See [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- See [FIX_BUILD_ERRORS.md](FIX_BUILD_ERRORS.md)

