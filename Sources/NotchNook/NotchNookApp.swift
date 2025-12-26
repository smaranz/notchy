import SwiftUI
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow?
    var statusItem: NSStatusItem?
    let windowManager = WindowManager()
    let screenManager = ScreenManager()
    let settingsManager = SettingsManager()
    private weak var hostingView: NSView?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        setupStatusBar()
        setupWindow()
    }
    
    private func setupStatusBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "plus.circle.fill", accessibilityDescription: "Notchy")
            button.image?.isTemplate = true
            button.action = #selector(statusBarButtonClicked)
            button.target = self
        }
    }
    
    @objc private func statusBarButtonClicked() {
        NSApp.activate(ignoringOtherApps: true)
        windowManager.toggleWindow()
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if let window = window {
            window.makeKeyAndOrderFront(nil)
        }
        return true
    }
    
    private func setupWindow() {
        let window = NotchWindow(
            contentRect: NSRect(x: 0, y: 0, width: 500, height: 180),
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        
        window.level = .floating
        window.collectionBehavior = [.canJoinAllSpaces, .stationary, .ignoresCycle]
        window.isOpaque = false
        window.backgroundColor = .clear
        window.hasShadow = false
        window.ignoresMouseEvents = false // CRITICAL: Always accept clicks
        window.acceptsMouseMovedEvents = true
        
        // Make window appear seamless with notch - no border, matches notch appearance
        window.titlebarAppearsTransparent = true
        window.titleVisibility = .hidden
        
        // Click handler will be set up after window is positioned
        
        let wrapperView = NSView()
        wrapperView.wantsLayer = true
        wrapperView.layer?.backgroundColor = NSColor.clear.cgColor
        wrapperView.canDrawConcurrently = false
        
        let contentView = ContentView()
            .environmentObject(windowManager)
            .environmentObject(screenManager)
            .environmentObject(settingsManager)
        
        let hostingView = FocusableHostingView(rootView: contentView)
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        hostingView.setAccessibilityIdentifier("NotchHost")
        self.hostingView = hostingView
        
        wrapperView.addSubview(hostingView)
        NSLayoutConstraint.activate([
            hostingView.topAnchor.constraint(equalTo: wrapperView.topAnchor),
            hostingView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            hostingView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            hostingView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor)
        ])
        
        window.contentView = wrapperView
        window.initialFirstResponder = hostingView
                
        // Global event monitor for notch-area clicks
        setupGlobalClickMonitor(for: window)
        
        self.window = window
        windowManager.setWindow(window)
        screenManager.updateScreenConfiguration()
        
        // Start hidden - user clicks notch to show
        window.makeKeyAndOrderFront(nil)
        window.orderFrontRegardless() // Force window to front
        window.makeFirstResponder(hostingView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.windowManager.positionWindow()
            // Verify window is positioned correctly
            if let window = self.window {
                print("🔵 Window frame: \(window.frame)")
                print("🔵 Window alpha: \(window.alphaValue)")
                print("🔵 Window ignoresMouseEvents: \(window.ignoresMouseEvents)")
            }
        }
        
        // Listen for screen configuration changes
        NotificationCenter.default.addObserver(
            forName: NSApplication.didChangeScreenParametersNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.screenManager.updateScreenConfiguration()
            self?.windowManager.positionWindow()
        }
    }
    
    private var globalEventMonitor: Any?
    
    private func setupGlobalClickMonitor(for window: NSWindow) {
        // Monitor for mouse clicks in the notch area
        globalEventMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown]) { [weak self] _ in
            guard let self = self,
                  let screen = NSScreen.main else { return }
            
            let clickLocation = NSEvent.mouseLocation
            let screenFrame = screen.frame
            let safeAreaInsets = screen.safeAreaInsets
            let hasNotch = safeAreaInsets.top > 0
            
            if hasNotch {
                // Restrict clickable hotspot to a tight band around the notch to avoid toolbar hits
                let notchHeight: CGFloat = 32
                let notchWidth: CGFloat = 200
                let notchX = screenFrame.midX - (notchWidth / 2)
                let notchY = screenFrame.maxY - notchHeight
                
                let notchRect = NSRect(x: notchX, y: notchY, width: notchWidth, height: notchHeight)
                
                if notchRect.contains(clickLocation) {
                    print("🔵 Global click detected in notch area!")
                    NSApp.activate(ignoringOtherApps: true)
                    self.windowManager.toggleWindow()
                }
            }
        }
    }
    
    deinit {
        if let monitor = globalEventMonitor {
            NSEvent.removeMonitor(monitor)
        }
    }
    
}

// Hosting view that willingly becomes first responder so SwiftUI text inputs
// receive keyboard focus when the notch window is key.
final class FocusableHostingView<Content: View>: NSHostingView<Content> {
    override var acceptsFirstResponder: Bool { true }
    override var canBecomeKeyView: Bool { true }
}

@main
struct NotchyApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        SwiftUI.Settings {
            SettingsView()
                .environmentObject(appDelegate.settingsManager)
        }
    }
}
