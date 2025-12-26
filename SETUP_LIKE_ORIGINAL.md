# Setup Project Like Original Notchy

Based on the original Notchy app structure, here's how to create the project:

## Key Settings from Original Notchy

- **Bundle Identifier:** `lo.cafe.Notchy` (or use `com.notchy.app` for our version)
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
- **Product Name:** `Notchy`
- **Team:** (your team or None)
- **Organization Identifier:** `com.notchy` (or `lo.cafe` if you want exact match)
- **Bundle Identifier:** Will be `com.notchy.Notchy` (or `lo.cafe.Notchy`)
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
- Delete `NotchyApp.swift`
- (We have our own versions)

### Step 5: Add Source Files
1. Right-click **Notchy** folder → **Add Files to "Notchy"...**
2. Navigate to `Sources/Notchy/`
3. Select these **folders:**
   - `Models`
   - `Managers`
   - `Views`
   - `Widgets`
   - `Utilities`
4. **Settings:**
   - ✅ **Create groups**
   - ❌ **Copy items if needed** (UNCHECKED!)
   - ✅ **Add to targets: Notchy**
5. Click **Add**

### Step 6: Add Info.plist
1. Right-click **Notchy** folder → **Add Files...**
2. Select `Sources/Notchy/Info.plist`
3. Same settings as above
4. Click **Add**

### Step 7: Configure Build Settings (Match Original)

**General Tab:**
- **Minimum Deployments:** macOS 14.6 ✅

**Build Settings Tab:**
- Search "Info.plist"
  - **Info.plist File:** `Sources/Notchy/Info.plist`
  - **Generate Info.plist File:** NO
- Search "Bundle Identifier"
  - **Product Bundle Identifier:** `com.notchy.app` (or `lo.cafe.Notchy`)

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
- Uses `com.notchy.app` bundle ID (original uses `lo.cafe.Notchy`)
- Simpler structure (no Sparkle updates, no complex dependencies)
- Open source and free

But the core structure matches:
- ✅ macOS 14.6+ requirement
- ✅ SwiftUI interface
- ✅ Background app (LSUIElement)
- ✅ Utilities category

