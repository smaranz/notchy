import SwiftUI
import AppKit

struct LiveActionsView: View {
    @EnvironmentObject var settingsManager: SettingsManager
    @StateObject private var mediaController = MediaController()
    
    var body: some View {
        HStack(spacing: 6) {
            // Media Controls
            if mediaController.isPlaying {
                Button(action: {
                    mediaController.togglePlayPause()
                }) {
                    Image(systemName: mediaController.isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 14))
                }
                .buttonStyle(.plain)
                .frame(width: 28, height: 28)
                
                Button(action: {
                    mediaController.skipNext()
                }) {
                    Image(systemName: "forward.fill")
                        .font(.system(size: 12))
                }
                .buttonStyle(.plain)
                .frame(width: 28, height: 28)
            }
            
            // Screenshot
            Button(action: {
                takeScreenshot()
            }) {
                Image(systemName: "camera.fill")
                    .font(.system(size: 14))
            }
            .buttonStyle(.plain)
            .frame(width: 28, height: 28)
            .help("Take Screenshot")
        }
        .frame(height: 50)
    }
    
    private func takeScreenshot() {
        let task = Process()
        task.launchPath = "/usr/sbin/screencapture"
        task.arguments = ["-i", "-c"] // Interactive, copy to clipboard
        task.launch()
    }
}

