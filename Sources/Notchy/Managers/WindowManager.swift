import AppKit
import SwiftUI
import QuartzCore

class WindowManager: ObservableObject {
    private weak var window: NSWindow?
    private let defaultWidth: CGFloat = 500
    private let defaultHeight: CGFloat = 180
    private let hiddenNotchWidth: CGFloat = 200
    private let hiddenNotchHeight: CGFloat = 32
    @Published var isVisible: Bool = false
    private var hiddenFrame: NSRect = .zero
    private var visibleFrame: NSRect = .zero
    
    func setWindow(_ window: NSWindow) {
        self.window = window
        setupInitialPosition()
    }
    
    private func setupInitialPosition() {
        guard let window = window,
              let screen = NSScreen.main else { return }
        
        let screenFrame = screen.frame
        let visibleScreenFrame = screen.visibleFrame
        
        // Hidden position: small target near the notch to avoid intercepting toolbar clicks
        let hiddenY = screenFrame.maxY - hiddenNotchHeight
        hiddenFrame = NSRect(
            x: screenFrame.midX - (hiddenNotchWidth / 2),
            y: hiddenY,
            width: hiddenNotchWidth,
            height: hiddenNotchHeight
        )
        
        // Visible position: Horizontally centered, nav bar integrated into notch area
        // Center horizontally, then shift 100px to the left
        let visibleX = visibleScreenFrame.midX - (defaultWidth / 2) - 100
        
        // Position so the window sits on the notch - top edge at the very top of screen
        // Position window so its top edge aligns with the top of the screen (notch area)
        // In macOS, Y is bottom-left, so to have top at maxY, we use maxY - height
        let visibleY = screenFrame.maxY - defaultHeight
        
        visibleFrame = NSRect(
            x: visibleX,
            y: visibleY,
            width: defaultWidth,
            height: defaultHeight
        )
        
        // Start hidden - positioned exactly at notch
        if !isVisible {
            window.setFrame(hiddenFrame, display: true) // Display immediately
            window.alphaValue = 0.0
            window.isOpaque = false
            window.ignoresMouseEvents = true
            window.makeKeyAndOrderFront(nil) // Ensure window is frontmost for animations
        }
    }
    
    func positionWindow() {
        guard window != nil else { return }
        setupInitialPosition()
        if isVisible {
            showWindow()
        } else {
            hideWindow()
        }
    }
    
    func toggleWindow() {
        print("🔵 toggleWindow called - isVisible: \(isVisible)")
        if isVisible {
            hideWindow()
        } else {
            showWindow()
        }
    }
    
    func showWindow() {
        guard let window = window, !isVisible else { return }
        
        if NSApp.activationPolicy() == .prohibited {
            if !NSApp.setActivationPolicy(.accessory) {
                _ = NSApp.setActivationPolicy(.regular)
            }
        }
        window.ignoresMouseEvents = false
        
        // Reset to hidden position before animating
        window.setFrame(hiddenFrame, display: false)
        window.alphaValue = 0.0
        window.makeKeyAndOrderFront(nil)
        
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.26
            context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            context.allowsImplicitAnimation = true
            
            window.animator().setFrame(visibleFrame, display: true)
            window.animator().alphaValue = 1.0
        }, completionHandler: {
            window.makeKeyAndOrderFront(nil)
            window.makeMain()
            if let responder = window.initialFirstResponder {
                window.makeFirstResponder(responder)
            }
            self.isVisible = true
        })
    }
    
    func hideWindow() {
        guard let window = window, isVisible else { return }
        
        // Animate retracting upward into notch - like notch contracting
        // Keep top edge fixed, shrink upward
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.22
            context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            context.allowsImplicitAnimation = true
            
            // Animate height shrinking upward while keeping top edge fixed
            window.animator().setFrame(hiddenFrame, display: true)
            window.animator().alphaValue = 0.0
        }, completionHandler: {
            self.isVisible = false
            window.ignoresMouseEvents = true
            window.makeKeyAndOrderFront(nil)
            if NSApp.activationPolicy() != .prohibited {
                _ = NSApp.setActivationPolicy(.prohibited)
            }
        })
    }
    
    func updateWindowSize(width: CGFloat, height: CGFloat) {
        guard let window = window else { return }
        var frame = window.frame
        frame.size.width = width
        frame.size.height = height
        frame.origin.x = (NSScreen.main?.frame.midX ?? 0) - (width / 2)
        
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.2
            context.allowsImplicitAnimation = true
            window.setFrame(frame, display: true)
        }
    }
}

// Helper extension for smooth animations
extension CAMediaTimingFunction {
    static let easeOutCubic = CAMediaTimingFunction(controlPoints: 0.16, 1, 0.3, 1)
    static let easeInCubic = CAMediaTimingFunction(controlPoints: 0.4, 0, 0.2, 1)
    static let easeOutBack = CAMediaTimingFunction(controlPoints: 0.2, 1.3, 0.35, 1)
}
