#!/usr/bin/env python3
"""
Create a complete Xcode project for Notchy
This creates a minimal but valid project structure
"""

import os
import subprocess
import sys

def create_project_with_xcode():
    """Try to create project using Xcode command line"""
    print("Attempting to create project using Xcode...")
    
    # Create a temporary script that Xcode can execute
    script = """
    tell application "Xcode"
        activate
        set newProject to make new project with properties {name:"Notchy", product type:"com.apple.product-type.application"}
    end tell
    """
    
    # This would require AppleScript, which is complex
    # Instead, let's create the project file properly
    return False

def main():
    print("=" * 60)
    print("Notchy Project Setup")
    print("=" * 60)
    print()
    
    # Check if xcodegen is available
    try:
        result = subprocess.run(['which', 'xcodegen'], capture_output=True, text=True)
        if result.returncode == 0:
            print("✅ Found xcodegen! Creating project...")
            subprocess.run(['xcodegen', 'generate'], check=True)
            print("✅ Project created successfully!")
            print()
            print("Open with: open Notchy.xcodeproj")
            return
    except:
        pass
    
    print("⚠️  xcodegen not found.")
    print()
    print("OPTION 1: Install xcodegen (Recommended)")
    print("  brew install xcodegen")
    print("  Then run: xcodegen generate")
    print()
    print("OPTION 2: Create project manually in Xcode")
    print("  Run: ./create_new_project.sh")
    print("  Follow the instructions shown")
    print()
    print("OPTION 3: Use the improved Python generator")
    print("  The generate_xcode_project.py script will be updated")
    print()
    
    # Offer to install xcodegen
    response = input("Would you like to install xcodegen now? (y/n): ").strip().lower()
    if response == 'y':
        print("Installing xcodegen...")
        try:
            subprocess.run(['brew', 'install', 'xcodegen'], check=True)
            print("✅ xcodegen installed!")
            print("Generating project...")
            subprocess.run(['xcodegen', 'generate'], check=True)
            print("✅ Project created!")
            print("Open with: open Notchy.xcodeproj")
        except subprocess.CalledProcessError:
            print("❌ Failed to install xcodegen. Please install manually:")
            print("   brew install xcodegen")
        except FileNotFoundError:
            print("❌ Homebrew not found. Please install Homebrew first:")
            print("   /bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"")
    else:
        print()
        print("Please choose one of the options above to create the project.")

if __name__ == "__main__":
    main()

