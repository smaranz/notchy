# ⚠️ IMPORTANT: This is a macOS Project

## Make Sure You Create a macOS Project, NOT iOS!

When creating the project in Xcode:

1. **File → New → Project**
2. **Choose: macOS → App** ⚠️ Make sure it says "macOS" not "iOS"!
3. The template should say "macOS App" at the top

### How to Tell if You Have the Right Template:

✅ **Correct (macOS):**
- Template says "macOS App"
- Options show "macOS" platform
- Deployment target shows "macOS" versions

❌ **Wrong (iOS):**
- Template says "iOS App" 
- Options show "iOS" platform
- Deployment target shows "iOS" versions

### If You Accidentally Created iOS Project:

1. Close Xcode
2. Delete the project folder
3. Start over with **macOS → App** template

### Why This Matters:

- Notchy uses macOS-specific APIs (NSScreen, NSWindow, etc.)
- iOS projects won't have access to these APIs
- The app won't compile if created as iOS project

---

**Remember: macOS → App, NOT iOS → App!**

