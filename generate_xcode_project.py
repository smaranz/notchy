#!/usr/bin/env python3
"""
Generate Xcode project file for Notchy
"""

import os
import uuid
import json

def generate_uuid():
    """Generate a 24-character hex string for Xcode UUIDs"""
    return uuid.uuid4().hex[:24].upper()

# Generate all UUIDs
project_uuid = generate_uuid()
main_group_uuid = generate_uuid()
products_group_uuid = generate_uuid()
sources_group_uuid = generate_uuid()
views_group_uuid = generate_uuid()
widgets_group_uuid = generate_uuid()
managers_group_uuid = generate_uuid()
models_group_uuid = generate_uuid()
utilities_group_uuid = generate_uuid()

target_uuid = generate_uuid()
sources_phase_uuid = generate_uuid()
frameworks_phase_uuid = generate_uuid()
resources_phase_uuid = generate_uuid()

debug_config_uuid = generate_uuid()
release_config_uuid = generate_uuid()
target_debug_config_uuid = generate_uuid()
target_release_config_uuid = generate_uuid()

project_config_list_uuid = generate_uuid()
target_config_list_uuid = generate_uuid()

# File UUIDs
files = {
    'NotchyApp.swift': generate_uuid(),
    'ContentView.swift': generate_uuid(),
    'WidgetContainer.swift': generate_uuid(),
    'FileShelfView.swift': generate_uuid(),
    'LiveActionsView.swift': generate_uuid(),
    'SettingsView.swift': generate_uuid(),
    'ClockWidget.swift': generate_uuid(),
    'CalendarWidget.swift': generate_uuid(),
    'SystemInfoWidget.swift': generate_uuid(),
    'MediaControlWidget.swift': generate_uuid(),
    'WindowManager.swift': generate_uuid(),
    'ScreenManager.swift': generate_uuid(),
    'SettingsManager.swift': generate_uuid(),
    'Widget.swift': generate_uuid(),
    'FileItem.swift': generate_uuid(),
    'Settings.swift': generate_uuid(),
    'GestureRecognizer.swift': generate_uuid(),
    'MediaController.swift': generate_uuid(),
    'FileUtilities.swift': generate_uuid(),
    'Info.plist': generate_uuid(),
}

app_product_uuid = generate_uuid()

# Build file UUIDs (one for each source file)
build_files = {name: generate_uuid() for name in files.keys() if name != 'Info.plist'}

project_content = f'''// !$*UTF8*$!
{{
	archiveVersion = 1;
	classes = {{
	}};
	objectVersion = 56;
	objects = {{

/* Begin PBXBuildFile section */
'''
for name, uuid in build_files.items():
    project_content += f'''		{build_files[name]} /* {name} */ = {{isa = PBXBuildFile; fileRef = {files[name]} /* {name} */; }};\n'''

project_content += f'''/* End PBXBuildFile section */

/* Begin PBXFileReference section */
		{app_product_uuid} /* Notchy.app */ = {{isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = Notchy.app; sourceTree = BUILT_PRODUCTS_DIR; }};
'''

for name, uuid in files.items():
    file_type = "text.plist.xml" if name == "Info.plist" else "sourcecode.swift"
    project_content += f'''		{files[name]} /* {name} */ = {{isa = PBXFileReference; lastKnownFileType = {file_type}; path = {name}; sourceTree = "<group>"; }};\n'''

project_content += f'''/* End PBXFileReference section */

/* Begin PBXGroup section */
		{main_group_uuid} = {{
			isa = PBXGroup;
			children = (
				{sources_group_uuid} /* Sources */,
				{products_group_uuid} /* Products */,
			);
			sourceTree = "<group>";
		}};
		{products_group_uuid} = {{
			isa = PBXGroup;
			children = (
				{app_product_uuid} /* Notchy.app */,
			);
			name = Products;
			sourceTree = "<group>";
		}};
		{sources_group_uuid} = {{
			isa = PBXGroup;
			children = (
				{files['NotchyApp.swift']} /* NotchyApp.swift */,
				{views_group_uuid} /* Views */,
				{widgets_group_uuid} /* Widgets */,
				{managers_group_uuid} /* Managers */,
				{models_group_uuid} /* Models */,
				{utilities_group_uuid} /* Utilities */,
				{files['Info.plist']} /* Info.plist */,
			);
			path = Sources/Notchy;
			sourceTree = "<group>";
		}};
		{views_group_uuid} = {{
			isa = PBXGroup;
			children = (
				{files['ContentView.swift']} /* ContentView.swift */,
				{files['WidgetContainer.swift']} /* WidgetContainer.swift */,
				{files['FileShelfView.swift']} /* FileShelfView.swift */,
				{files['LiveActionsView.swift']} /* LiveActionsView.swift */,
				{files['SettingsView.swift']} /* SettingsView.swift */,
			);
			path = Views;
			sourceTree = "<group>";
		}};
		{widgets_group_uuid} = {{
			isa = PBXGroup;
			children = (
				{files['ClockWidget.swift']} /* ClockWidget.swift */,
				{files['CalendarWidget.swift']} /* CalendarWidget.swift */,
				{files['SystemInfoWidget.swift']} /* SystemInfoWidget.swift */,
				{files['MediaControlWidget.swift']} /* MediaControlWidget.swift */,
			);
			path = Widgets;
			sourceTree = "<group>";
		}};
		{managers_group_uuid} = {{
			isa = PBXGroup;
			children = (
				{files['WindowManager.swift']} /* WindowManager.swift */,
				{files['ScreenManager.swift']} /* ScreenManager.swift */,
				{files['SettingsManager.swift']} /* SettingsManager.swift */,
			);
			path = Managers;
			sourceTree = "<group>";
		}};
		{models_group_uuid} = {{
			isa = PBXGroup;
			children = (
				{files['Widget.swift']} /* Widget.swift */,
				{files['FileItem.swift']} /* FileItem.swift */,
				{files['Settings.swift']} /* Settings.swift */,
			);
			path = Models;
			sourceTree = "<group>";
		}};
		{utilities_group_uuid} = {{
			isa = PBXGroup;
			children = (
				{files['GestureRecognizer.swift']} /* GestureRecognizer.swift */,
				{files['MediaController.swift']} /* MediaController.swift */,
				{files['FileUtilities.swift']} /* FileUtilities.swift */,
			);
			path = Utilities;
			sourceTree = "<group>";
		}};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		{target_uuid} = {{
			isa = PBXNativeTarget;
			buildConfigurationList = {target_config_list_uuid} /* Build configuration list for PBXNativeTarget "Notchy" */;
			buildPhases = (
				{sources_phase_uuid} /* Sources */,
				{frameworks_phase_uuid} /* Frameworks */,
				{resources_phase_uuid} /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = Notchy;
			productName = Notchy;
			productReference = {app_product_uuid} /* Notchy.app */;
			productType = "com.apple.product-type.application";
		}};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		{project_uuid} /* Project object */ = {{
			isa = PBXProject;
			attributes = {{
				BuildIndependentTargetsInParallel = 1;
				LastSwiftUpdateCheck = 1500;
				LastUpgradeCheck = 1500;
			}};
			buildConfigurationList = {project_config_list_uuid} /* Build configuration list for PBXProject "Notchy" */;
			compatibilityVersion = "Xcode 14.0";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = {main_group_uuid};
			productRefGroup = {products_group_uuid} /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				{target_uuid} /* Notchy */,
			);
		}};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
		{resources_phase_uuid} /* Resources */ = {{
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		}};
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
		{sources_phase_uuid} /* Sources */ = {{
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
'''

for name, uuid in build_files.items():
    project_content += f'''				{build_files[name]} /* {name} in Sources */ = {{isa = PBXBuildFile; fileRef = {files[name]} /* {name} */; }};\n'''

project_content += f'''			);
			runOnlyForDeploymentPostprocessing = 0;
		}};
/* End PBXSourcesBuildPhase section */

/* Begin PBXFrameworksBuildPhase section */
		{frameworks_phase_uuid} /* Frameworks */ = {{
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		}};
/* End PBXFrameworksBuildPhase section */

/* Begin XCBuildConfiguration section */
		{debug_config_uuid} /* Debug */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{
				ALWAYS_SEARCH_USER_PATHS = NO;
				ASSETCATALOG_COMPILER = "apple";
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_ENABLE_OBJC_WEAK = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = dwarf;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_TESTABILITY = YES;
				ENABLE_USER_SCRIPT_SANDBOXING = YES;
				GCC_C_LANGUAGE_STANDARD = gnu17;
				GCC_DYNAMIC_NO_PIC = NO;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_OPTIMIZATION_LEVEL = 0;
				GCC_PREPROCESSOR_DEFINITIONS = (
					"DEBUG=1",
					"$(inherited)",
				);
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				LOCALIZATION_PREFERS_STRING_CATALOGS = YES;
				MACOSX_DEPLOYMENT_TARGET = 14.6;
				MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
				MTL_FAST_MATH = YES;
				ONLY_ACTIVE_ARCH = YES;
				SDKROOT = macosx;
				SWIFT_ACTIVE_COMPILATION_CONDITIONS = "DEBUG $(inherited)";
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
			}};
			name = Debug;
		}};
		{release_config_uuid} /* Release */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{
				ALWAYS_SEARCH_USER_PATHS = NO;
				ASSETCATALOG_COMPILER = "apple";
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_ENABLE_OBJC_WEAK = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
				ENABLE_NS_ASSERTIONS = NO;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_USER_SCRIPT_SANDBOXING = YES;
				GCC_C_LANGUAGE_STANDARD = gnu17;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				LOCALIZATION_PREFERS_STRING_CATALOGS = YES;
				MACOSX_DEPLOYMENT_TARGET = 14.6;
				MTL_ENABLE_DEBUG_INFO = NO;
				MTL_FAST_MATH = YES;
				SDKROOT = macosx;
				SWIFT_COMPILATION_MODE = wholemodule;
				SWIFT_OPTIMIZATION_LEVEL = "-O";
			}};
			name = Release;
		}};
		{target_debug_config_uuid} /* Debug */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{
				ASSETCATALOG_COMPILER_APPICON_NAME = "";
				ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = "";
				CODE_SIGN_ENTITLEMENTS = "";
				CODE_SIGN_STYLE = Automatic;
				COMBINE_HIDPI_IMAGES = YES;
				CURRENT_PROJECT_VERSION = 1;
				DEVELOPMENT_ASSET_PATHS = "";
				DEVELOPMENT_TEAM = "";
				ENABLE_HARDENED_RUNTIME = YES;
				ENABLE_PREVIEWS = YES;
				GENERATE_INFOPLIST_FILE = NO;
				INFOPLIST_FILE = Sources/Notchy/Info.plist;
				INFOPLIST_KEY_NSHumanReadableCopyright = "";
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/../Frameworks",
				);
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = "com.notchy.app";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_EMIT_LOC_STRINGS = YES;
				SWIFT_VERSION = 5.0;
			}};
			name = Debug;
		}};
		{target_release_config_uuid} /* Release */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{
				ASSETCATALOG_COMPILER_APPICON_NAME = "";
				ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = "";
				CODE_SIGN_ENTITLEMENTS = "";
				CODE_SIGN_STYLE = Automatic;
				COMBINE_HIDPI_IMAGES = YES;
				CURRENT_PROJECT_VERSION = 1;
				DEVELOPMENT_ASSET_PATHS = "";
				DEVELOPMENT_TEAM = "";
				ENABLE_HARDENED_RUNTIME = YES;
				ENABLE_PREVIEWS = YES;
				GENERATE_INFOPLIST_FILE = NO;
				INFOPLIST_FILE = Sources/Notchy/Info.plist;
				INFOPLIST_KEY_NSHumanReadableCopyright = "";
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/../Frameworks",
				);
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = "com.notchy.app";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_EMIT_LOC_STRINGS = YES;
				SWIFT_VERSION = 5.0;
			}};
			name = Release;
		}};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		{project_config_list_uuid} /* Build configuration list for PBXProject "Notchy" */ = {{
			isa = XCConfigurationList;
			buildConfigurations = (
				{debug_config_uuid} /* Debug */,
				{release_config_uuid} /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		}};
		{target_config_list_uuid} /* Build configuration list for PBXNativeTarget "Notchy" */ = {{
			isa = XCConfigurationList;
			buildConfigurations = (
				{target_debug_config_uuid} /* Debug */,
				{target_release_config_uuid} /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		}};
/* End XCConfigurationList section */
	}};
	rootObject = {project_uuid} /* Project object */;
}}
'''

# Write the project file
os.makedirs('Notchy.xcodeproj', exist_ok=True)
with open('Notchy.xcodeproj/project.pbxproj', 'w') as f:
    f.write(project_content)

# Create scheme file
scheme_dir = 'Notchy.xcodeproj/xcshareddata/xcschemes'
os.makedirs(scheme_dir, exist_ok=True)

scheme_content = f'''<?xml version="1.0" encoding="UTF-8"?>
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
               BlueprintIdentifier = "{target_uuid}"
               BuildableName = "Notchy.app"
               BlueprintName = "Notchy"
               ReferencedContainer = "container:Notchy.xcodeproj">
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
            BlueprintIdentifier = "{target_uuid}"
            BuildableName = "Notchy.app"
            BlueprintName = "Notchy"
            ReferencedContainer = "container:Notchy.xcodeproj">
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
            BlueprintIdentifier = "{target_uuid}"
            BuildableName = "Notchy.app"
            BlueprintName = "Notchy"
            ReferencedContainer = "container:Notchy.xcodeproj">
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
'''

with open(f'{scheme_dir}/Notchy.xcscheme', 'w') as f:
    f.write(scheme_content)

print("✅ Xcode project created successfully!")
print("")
print("To open the project:")
print("  open Notchy.xcodeproj")
print("")
print("The project is ready to build and run!")

