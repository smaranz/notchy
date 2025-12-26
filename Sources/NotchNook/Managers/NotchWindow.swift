import AppKit

/// Borderless window that can become key/main so text inputs accept keyboard focus.
final class NotchWindow: NSWindow {
    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { true }
}
