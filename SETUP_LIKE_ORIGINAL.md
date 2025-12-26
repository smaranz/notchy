# Setup Project Like Original NotchNook

Based on the original NotchNook app structure, here's how to create the project:

## Key Settings from Original NotchNook

- **Bundle Identifier:** `lo.cafe.NotchNook` (or use `com.notchnook.app` for our version)
- **Minimum macOS Version:** 14.6 ✅ (matches original)
- **Platform:** macOS (MacOSX) ✅
- **App Category:** Utilities
- **LSUIElement:** true (runs as background/menu bar app)

## Create Project in Xcode

### Step 1: New Project
1. Open Xcode
2. **File → New → Project** (⌘⇧N)
3. **Choose: macOS → App** ⚠️ Make sure it's macOS, not iOS!
4. Click **Next**

### Step 2: Configure (Match Original Structure)
- **Product Name:** `NotchNook`
- **Team:** (your team or None)
- **Organization Identifier:** `com.notchnook` (or `lo.cafe` if you want exact match)
- **Bundle Identifier:** Will be `com.notchnook.NotchNook` (or `lo.cafe.NotchNook`)
- **Interface:** **SwiftUI** ⚠️ Important!
- **Language:** **Swift**
- **☐ Use Core Data** (UNCHECK)
- **☐ Include Tests** (UNCHECK)

Click **Next**

### Step 3: Save
- Location: `/Users/sandarshdevappa/smaran/projects/notch`
- **☐ Create Git repository** (UNCHECK - we have git)
- Click **Create**

### Step 4: Delete Default Files
- Delete `ContentView.swift`
- Delete `NotchNookApp.swift`
- (We have our own versions)

### Step 5: Add Source Files
1. Right-click **NotchNook** folder → **Add Files to "NotchNook"...**
2. Navigate to `Sources/NotchNook/`
3. Select these **folders:**
   - `Models`
   - `Managers`
   - `Views`
   - `Widgets`
   - `Utilities`
4. **Settings:**
   - ✅ **Create groups**
   - ❌ **Copy items if needed** (UNCHECKED!)
   - ✅ **Add to targets: NotchNook**
5. Click **Add**

### Step 6: Add Info.plist
1. Right-click **NotchNook** folder → **Add Files...**
2. Select `Sources/NotchNook/Info.plist`
3. Same settings as above
4. Click **Add**

### Step 7: Configure Build Settings (Match Original)

**General Tab:**
- **Minimum Deployments:** macOS 14.6 ✅

**Build Settings Tab:**
- Search "Info.plist"
  - **Info.plist File:** `Sources/NotchNook/Info.plist`
  - **Generate Info.plist File:** NO
- Search "Bundle Identifier"
  - **Product Bundle Identifier:** `com.notchnook.app` (or `lo.cafe.NotchNook`)

**Build Phases Tab:**
- **Copy Bundle Resources:** Make sure Info.plist is NOT listed here
- If it is, select it and press Delete

### Step 8: Verify Info.plist Settings

Our Info.plist is already configured with:
- ✅ `LSMinimumSystemVersion: 14.6` (matches original)
- ✅ `LSApplicationCategoryType: public.app-category.utilities` (matches original)
- ✅ `LSUIElement: true` (runs as background app, matches original)
- ✅ `CFBundlePackageType: APPL` (macOS app, matches original)

### Step 9: Build and Run

Press **⌘R**

The app should build and launch, positioning itself in the notch area!

---

## Differences from Original

Our free version:
- Uses `com.notchnook.app` bundle ID (original uses `lo.cafe.NotchNook`)
- Simpler structure (no Sparkle updates, no complex dependencies)
- Open source and free

But the core structure matches:
- ✅ macOS 14.6+ requirement
- ✅ SwiftUI interface
- ✅ Background app (LSUIElement)
- ✅ Utilities category

