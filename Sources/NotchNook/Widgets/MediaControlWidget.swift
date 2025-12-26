import SwiftUI
import MediaPlayer

struct MediaControlWidget: Widget {
    var id: String { "mediaControl" }
    var name: String { "Media Control" }
    var icon: String { "music.note" }
    var isEnabled: Bool = true
    
    func makeView() -> AnyView {
        AnyView(MediaControlWidgetView())
    }
}

struct MediaControlWidgetView: View {
    @StateObject private var mediaController = MediaController()
    
    var body: some View {
        Group {
            if mediaController.isPlaying, let nowPlaying = mediaController.nowPlaying {
                VStack(spacing: 2) {
                    HStack(spacing: 4) {
                        Button(action: {
                            mediaController.togglePlayPause()
                        }) {
                            Image(systemName: mediaController.isPlaying ? "pause.fill" : "play.fill")
                                .font(.system(size: 10))
                        }
                        .buttonStyle(.plain)
                        
                        Button(action: {
                            mediaController.skipNext()
                        }) {
                            Image(systemName: "forward.fill")
                                .font(.system(size: 8))
                        }
                        .buttonStyle(.plain)
                    }
                    
                    Text(nowPlaying.title)
                        .font(.system(size: 7))
                        .lineLimit(1)
                        .truncationMode(.middle)
                        .frame(maxWidth: 45)
                }
            } else {
                Image(systemName: "music.note")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
            }
        }
        .frame(width: 50, height: 50)
    }
}

