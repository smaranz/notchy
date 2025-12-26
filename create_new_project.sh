#!/bin/bash

# Create a new Xcode project for NotchNook
# This script creates the project structure properly

set -e

PROJECT_NAME="NotchNook"
BUNDLE_ID="com.notchnook.app"

echo "Creating new Xcode project: $PROJECT_NAME"

# Check if we can use xcodegen
if command -v xcodegen &> /dev/null; then
    echo "Using xcodegen to create project..."
    xcodegen generate
    echo "✅ Project created with xcodegen!"
    exit 0
fi

# Otherwise, create project manually using Xcode command line
echo "Creating project structure..."

# Create project directory
mkdir -p "$PROJECT_NAME.xcodeproj/xcshareddata/xcschemes"
mkdir -p "$PROJECT_NAME.xcodeproj/project.xcworkspace/xcshareddata"

# Create workspace data
cat > "$PROJECT_NAME.xcodeproj/project.xcworkspace/contents.xcworkspacedata" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<Workspace
   version = "1.0">
   <FileRef
      location = "self:">
   </FileRef>
</Workspace>
EOF

# Create scheme
cat > "$PROJECT_NAME.xcodeproj/xcshareddata/xcschemes/$PROJECT_NAME.xcscheme" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<Scheme
   LastUpgradeVersion = "1500"
   version = "1.7">
   <BuildAction
      parallelizeBuildables = "YES"
      buildImplicitDependencies = "YES">
      <BuildActionEntries>
         <BuildActionEntry
            buildForTesting = "YES"
            buildForRunning = "YES"
            buildForProfiling = "YES"
            buildForArchiving = "YES"
            buildForAnalyzing = "YES">
            <BuildableReference
               BuildableIdentifier = "primary"
               BlueprintIdentifier = "TARGET_ID"
               BuildableName = "NotchNook.app"
               BlueprintName = "NotchNook"
               ReferencedContainer = "container:NotchNook.xcodeproj">
            </BuildableReference>
         </BuildActionEntry>
      </BuildActionEntries>
   </BuildAction>
   <TestAction
      buildConfiguration = "Debug"
      selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
      selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
      shouldUseLaunchSchemeArgsEnv = "YES"
      shouldAutocreateTestPlan = "YES">
      <Testables>
      </Testables>
   </TestAction>
   <LaunchAction
      buildConfiguration = "Debug"
      selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
      selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
      launchStyle = "0"
      useCustomWorkingDirectory = "NO"
      ignoresPersistentStateOnLaunch = "NO"
      debugDocumentVersioning = "YES"
      debugServiceExtension = "internal"
      allowLocationSimulation = "YES">
      <BuildableProductRunnable
         runnableDebuggingMode = "0">
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "TARGET_ID"
            BuildableName = "NotchNook.app"
            BlueprintName = "NotchNook"
            ReferencedContainer = "container:NotchNook.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </LaunchAction>
   <ProfileAction
      buildConfiguration = "Release"
      shouldUseLaunchSchemeArgsEnv = "YES"
      savedToolIdentifier = ""
      useCustomWorkingDirectory = "NO"
      debugDocumentVersioning = "YES">
      <BuildableProductRunnable
         runnableDebuggingMode = "0">
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "TARGET_ID"
            BuildableName = "NotchNook.app"
            BlueprintName = "NotchNook"
            ReferencedContainer = "container:NotchNook.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </ProfileAction>
   <AnalyzeAction
      buildConfiguration = "Debug">
   </AnalyzeAction>
   <ArchiveAction
      buildConfiguration = "Release"
      revealArchiveInOrganizer = "YES">
   </ArchiveAction>
</Scheme>
EOF

echo ""
echo "⚠️  Project structure created, but you need to create the project.pbxproj file."
echo ""
echo "Please follow these steps:"
echo ""
echo "1. Open Xcode"
echo "2. File → New → Project"
echo "3. Choose 'macOS' → 'App'"
echo "4. Click Next"
echo "5. Fill in:"
echo "   - Product Name: $PROJECT_NAME"
echo "   - Team: (your team or None)"
echo "   - Organization Identifier: com.notchnook"
echo "   - Interface: SwiftUI"
echo "   - Language: Swift"
echo "   - ☐ Use Core Data (uncheck)"
echo "   - ☐ Include Tests (uncheck)"
echo "6. Click Next"
echo "7. Save in: $(pwd)"
echo "8. Click Create"
echo ""
echo "Then:"
echo "9. Delete the default ContentView.swift and NotchNookApp.swift"
echo "10. Right-click on '$PROJECT_NAME' folder → Add Files to '$PROJECT_NAME'..."
echo "11. Navigate to Sources/NotchNook/"
echo "12. Select all folders: Models, Managers, Views, Widgets, Utilities"
echo "13. Ensure 'Create groups' is selected"
echo "14. Ensure 'Copy items if needed' is UNCHECKED"
echo "15. Click Add"
echo ""
echo "Configure:"
echo "16. Select '$PROJECT_NAME' project → '$PROJECT_NAME' target"
echo "17. General tab → Minimum Deployments: macOS 14.6"
echo "18. Build Settings → Info.plist File: Sources/NotchNook/Info.plist"
echo "19. Build Settings → Generate Info.plist File: NO"
echo ""
echo "Then build with ⌘R!"

