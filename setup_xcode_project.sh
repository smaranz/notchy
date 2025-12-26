#!/bin/bash

# Script to create Xcode project for Notchy
# This script creates a proper Xcode project structure

set -e

PROJECT_NAME="Notchy"
BUNDLE_ID="com.notchy.app"
MIN_OS_VERSION="14.6"

echo "Creating Xcode project for $PROJECT_NAME..."

# Create project directory
mkdir -p "$PROJECT_NAME.xcodeproj"

# Create project.pbxproj file
cat > "$PROJECT_NAME.xcodeproj/project.pbxproj" << 'EOF'
// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 56;
	objects = {

/* Begin PBXBuildFile section */
		APP_ENTRY /* NotchyApp.swift */ = {isa = PBXBuildFile; fileRef = APP_ENTRY_REF /* NotchyApp.swift */; };
		CONTENT_VIEW /* ContentView.swift */ = {isa = PBXBuildFile; fileRef = CONTENT_VIEW_REF /* ContentView.swift */; };
		WIDGET_CONTAINER /* WidgetContainer.swift */ = {isa = PBXBuildFile; fileRef = WIDGET_CONTAINER_REF /* WidgetContainer.swift */; };
		FILE_SHELF /* FileShelfView.swift */ = {isa = PBXBuildFile; fileRef = FILE_SHELF_REF /* FileShelfView.swift */; };
		LIVE_ACTIONS /* LiveActionsView.swift */ = {isa = PBXBuildFile; fileRef = LIVE_ACTIONS_REF /* LiveActionsView.swift */; };
		SETTINGS_VIEW /* SettingsView.swift */ = {isa = PBXBuildFile; fileRef = SETTINGS_VIEW_REF /* SettingsView.swift */; };
		CLOCK_WIDGET /* ClockWidget.swift */ = {isa = PBXBuildFile; fileRef = CLOCK_WIDGET_REF /* ClockWidget.swift */; };
		CALENDAR_WIDGET /* CalendarWidget.swift */ = {isa = PBXBuildFile; fileRef = CALENDAR_WIDGET_REF /* CalendarWidget.swift */; };
		SYSTEM_INFO_WIDGET /* SystemInfoWidget.swift */ = {isa = PBXBuildFile; fileRef = SYSTEM_INFO_WIDGET_REF /* SystemInfoWidget.swift */; };
		MEDIA_CONTROL_WIDGET /* MediaControlWidget.swift */ = {isa = PBXBuildFile; fileRef = MEDIA_CONTROL_WIDGET_REF /* MediaControlWidget.swift */; };
		WINDOW_MANAGER /* WindowManager.swift */ = {isa = PBXBuildFile; fileRef = WINDOW_MANAGER_REF /* WindowManager.swift */; };
		SCREEN_MANAGER /* ScreenManager.swift */ = {isa = PBXBuildFile; fileRef = SCREEN_MANAGER_REF /* ScreenManager.swift */; };
		SETTINGS_MANAGER /* SettingsManager.swift */ = {isa = PBXBuildFile; fileRef = SETTINGS_MANAGER_REF /* SettingsManager.swift */; };
		WIDGET_MODEL /* Widget.swift */ = {isa = PBXBuildFile; fileRef = WIDGET_MODEL_REF /* Widget.swift */; };
		FILE_ITEM /* FileItem.swift */ = {isa = PBXBuildFile; fileRef = FILE_ITEM_REF /* FileItem.swift */; };
		SETTINGS_MODEL /* Settings.swift */ = {isa = PBXBuildFile; fileRef = SETTINGS_MODEL_REF /* Settings.swift */; };
		GESTURE_RECOGNIZER /* GestureRecognizer.swift */ = {isa = PBXBuildFile; fileRef = GESTURE_RECOGNIZER_REF /* GestureRecognizer.swift */; };
		MEDIA_CONTROLLER /* MediaController.swift */ = {isa = PBXBuildFile; fileRef = MEDIA_CONTROLLER_REF /* MediaController.swift */; };
		FILE_UTILITIES /* FileUtilities.swift */ = {isa = PBXBuildFile; fileRef = FILE_UTILITIES_REF /* FileUtilities.swift */; };
/* End PBXBuildFile section */

/* Begin PBXFileReference section */
		APP_ENTRY_REF /* NotchyApp.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = NotchyApp.swift; sourceTree = "<group>"; };
		CONTENT_VIEW_REF /* ContentView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ContentView.swift; sourceTree = "<group>"; };
		WIDGET_CONTAINER_REF /* WidgetContainer.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = WidgetContainer.swift; sourceTree = "<group>"; };
		FILE_SHELF_REF /* FileShelfView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = FileShelfView.swift; sourceTree = "<group>"; };
		LIVE_ACTIONS_REF /* LiveActionsView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = LiveActionsView.swift; sourceTree = "<group>"; };
		SETTINGS_VIEW_REF /* SettingsView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SettingsView.swift; sourceTree = "<group>"; };
		CLOCK_WIDGET_REF /* ClockWidget.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ClockWidget.swift; sourceTree = "<group>"; };
		CALENDAR_WIDGET_REF /* CalendarWidget.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = CalendarWidget.swift; sourceTree = "<group>"; };
		SYSTEM_INFO_WIDGET_REF /* SystemInfoWidget.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SystemInfoWidget.swift; sourceTree = "<group>"; };
		MEDIA_CONTROL_WIDGET_REF /* MediaControlWidget.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = MediaControlWidget.swift; sourceTree = "<group>"; };
		WINDOW_MANAGER_REF /* WindowManager.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = WindowManager.swift; sourceTree = "<group>"; };
		SCREEN_MANAGER_REF /* ScreenManager.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ScreenManager.swift; sourceTree = "<group>"; };
		SETTINGS_MANAGER_REF /* SettingsManager.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SettingsManager.swift; sourceTree = "<group>"; };
		WIDGET_MODEL_REF /* Widget.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = Widget.swift; sourceTree = "<group>"; };
		FILE_ITEM_REF /* FileItem.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = FileItem.swift; sourceTree = "<group>"; };
		SETTINGS_MODEL_REF /* Settings.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = Settings.swift; sourceTree = "<group>"; };
		GESTURE_RECOGNIZER_REF /* GestureRecognizer.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = GestureRecognizer.swift; sourceTree = "<group>"; };
		MEDIA_CONTROLLER_REF /* MediaController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = MediaController.swift; sourceTree = "<group>"; };
		FILE_UTILITIES_REF /* FileUtilities.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = FileUtilities.swift; sourceTree = "<group>"; };
		PRODUCT_REF /* Notchy.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = Notchy.app; sourceTree = BUILT_PRODUCTS_DIR; };
		INFO_PLIST_REF /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
/* End PBXFileReference section */

/* Begin PBXGroup section */
		SOURCE_GROUP = {
			isa = PBXGroup;
			children = (
				APP_ENTRY_REF /* NotchyApp.swift */,
				VIEWS_GROUP /* Views */,
				WIDGETS_GROUP /* Widgets */,
				MANAGERS_GROUP /* Managers */,
				MODELS_GROUP /* Models */,
				UTILITIES_GROUP /* Utilities */,
				INFO_PLIST_REF /* Info.plist */,
			);
			path = Sources/Notchy;
			sourceTree = "<group>";
		};
		VIEWS_GROUP = {
			isa = PBXGroup;
			children = (
				CONTENT_VIEW_REF /* ContentView.swift */,
				WIDGET_CONTAINER_REF /* WidgetContainer.swift */,
				FILE_SHELF_REF /* FileShelfView.swift */,
				LIVE_ACTIONS_REF /* LiveActionsView.swift */,
				SETTINGS_VIEW_REF /* SettingsView.swift */,
			);
			path = Views;
			sourceTree = "<group>";
		};
		WIDGETS_GROUP = {
			isa = PBXGroup;
			children = (
				CLOCK_WIDGET_REF /* ClockWidget.swift */,
				CALENDAR_WIDGET_REF /* CalendarWidget.swift */,
				SYSTEM_INFO_WIDGET_REF /* SystemInfoWidget.swift */,
				MEDIA_CONTROL_WIDGET_REF /* MediaControlWidget.swift */,
			);
			path = Widgets;
			sourceTree = "<group>";
		};
		MANAGERS_GROUP = {
			isa = PBXGroup;
			children = (
				WINDOW_MANAGER_REF /* WindowManager.swift */,
				SCREEN_MANAGER_REF /* ScreenManager.swift */,
				SETTINGS_MANAGER_REF /* SettingsManager.swift */,
			);
			path = Managers;
			sourceTree = "<group>";
		};
		MODELS_GROUP = {
			isa = PBXGroup;
			children = (
				WIDGET_MODEL_REF /* Widget.swift */,
				FILE_ITEM_REF /* FileItem.swift */,
				SETTINGS_MODEL_REF /* Settings.swift */,
			);
			path = Models;
			sourceTree = "<group>";
		};
		UTILITIES_GROUP = {
			isa = PBXGroup;
			children = (
				GESTURE_RECOGNIZER_REF /* GestureRecognizer.swift */,
				MEDIA_CONTROLLER_REF /* MediaController.swift */,
				FILE_UTILITIES_REF /* FileUtilities.swift */,
			);
			path = Utilities;
			sourceTree = "<group>";
		};
		PROJECT_ROOT = {
			isa = PBXGroup;
			children = (
				SOURCE_GROUP /* Sources */,
				PRODUCTS_GROUP /* Products */,
			);
			sourceTree = "<group>";
		};
		PRODUCTS_GROUP = {
			isa = PBXGroup;
			children = (
				PRODUCT_REF /* Notchy.app */,
			);
			name = Products;
			sourceTree = "<group>";
		};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		APP_TARGET = {
			isa = PBXNativeTarget;
			buildConfigurationList = TARGET_BUILD_CONFIG_LIST;
			buildPhases = (
				SOURCES_BUILD_PHASE,
				FRAMEWORKS_BUILD_PHASE,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = Notchy;
			productName = Notchy;
			productReference = PRODUCT_REF /* Notchy.app */;
			productType = "com.apple.product-type.application";
		};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		PROJECT_OBJECT = {
			isa = PBXProject;
			attributes = {
				BuildIndependentTargetsInParallel = 1;
				LastSwiftUpdateCheck = 1500;
				LastUpgradeCheck = 1500;
			};
			buildConfigurationList = PROJECT_BUILD_CONFIG_LIST;
			compatibilityVersion = "Xcode 14.0";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = PROJECT_ROOT;
			productRefGroup = PRODUCTS_GROUP /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				APP_TARGET /* Notchy */,
			);
		};
/* End PBXProject section */

/* Begin PBXSourcesBuildPhase section */
		SOURCES_BUILD_PHASE = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				APP_ENTRY /* NotchyApp.swift */,
				CONTENT_VIEW /* ContentView.swift */,
				WIDGET_CONTAINER /* WidgetContainer.swift */,
				FILE_SHELF /* FileShelfView.swift */,
				LIVE_ACTIONS /* LiveActionsView.swift */,
				SETTINGS_VIEW /* SettingsView.swift */,
				CLOCK_WIDGET /* ClockWidget.swift */,
				CALENDAR_WIDGET /* CalendarWidget.swift */,
				SYSTEM_INFO_WIDGET /* SystemInfoWidget.swift */,
				MEDIA_CONTROL_WIDGET /* MediaControlWidget.swift */,
				WINDOW_MANAGER /* WindowManager.swift */,
				SCREEN_MANAGER /* ScreenManager.swift */,
				SETTINGS_MANAGER /* SettingsManager.swift */,
				WIDGET_MODEL /* Widget.swift */,
				FILE_ITEM /* FileItem.swift */,
				SETTINGS_MODEL /* Settings.swift */,
				GESTURE_RECOGNIZER /* GestureRecognizer.swift */,
				MEDIA_CONTROLLER /* MediaController.swift */,
				FILE_UTILITIES /* FileUtilities.swift */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXSourcesBuildPhase section */

/* Begin PBXFrameworksBuildPhase section */
		FRAMEWORKS_BUILD_PHASE = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXFrameworksBuildPhase section */

/* Begin XCBuildConfiguration section */
		DEBUG_BUILD_CONFIG = {
			isa = XCBuildConfiguration;
			buildSettings = {
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
			};
			name = Debug;
		};
		RELEASE_BUILD_CONFIG = {
			isa = XCBuildConfiguration;
			buildSettings = {
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
			};
			name = Release;
		};
		APP_DEBUG_CONFIG = {
			isa = XCBuildConfiguration;
			buildSettings = {
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
			};
			name = Debug;
		};
		APP_RELEASE_CONFIG = {
			isa = XCBuildConfiguration;
			buildSettings = {
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
			};
			name = Release;
		};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		TARGET_BUILD_CONFIG_LIST = {
			isa = XCConfigurationList;
			buildConfigurations = (
				APP_DEBUG_CONFIG /* Debug */,
				APP_RELEASE_CONFIG /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		PROJECT_BUILD_CONFIG_LIST = {
			isa = XCConfigurationList;
			buildConfigurations = (
				DEBUG_BUILD_CONFIG /* Debug */,
				RELEASE_BUILD_CONFIG /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
/* End XCConfigurationList section */
	};
	rootObject = PROJECT_OBJECT /* Project object */;
}
EOF

echo "Xcode project created successfully!"
echo ""
echo "To open the project:"
echo "  open $PROJECT_NAME.xcodeproj"
echo ""
echo "Note: You may need to adjust file references in Xcode if the paths don't match exactly."

