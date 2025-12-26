import AppKit
import SwiftUI

class ScreenManager: ObservableObject {
    @Published var primaryScreen: NSScreen?
    @Published var hasNotch: Bool = false
    @Published var notchInsets: NSEdgeInsets = NSEdgeInsets()
    
    init() {
        updateScreenConfiguration()
    }
    
    func updateScreenConfiguration() {
        primaryScreen = NSScreen.main
        
        if let screen = primaryScreen {
            let safeAreaInsets = screen.safeAreaInsets
            hasNotch = safeAreaInsets.top > 0
            notchInsets = safeAreaInsets
        } else {
            hasNotch = false
            notchInsets = NSEdgeInsets()
        }
    }
    
    func getAllScreens() -> [NSScreen] {
        return NSScreen.screens
    }
    
    func getScreenFrame(for screen: NSScreen) -> NSRect {
        return screen.frame
    }
}

