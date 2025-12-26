import SwiftUI
import AppKit
import AVFoundation

struct ContentView: View {
    @EnvironmentObject var windowManager: WindowManager
    @EnvironmentObject var screenManager: ScreenManager
    @EnvironmentObject var settingsManager: SettingsManager
    @StateObject private var widgetRegistry = WidgetRegistry()
    @StateObject private var fileShelfManager = FileShelfManager()
    @StateObject private var notesManager = NotesManager()
    @State private var selectedTab: TabSelection = .nook
    @State private var showSettings = false
    
    enum TabSelection {
        case nook
        case notes
        case tray
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Top bar with tabs and settings
            HStack(alignment: .center, spacing: 12) {
                // Tab selector
                HStack(spacing: 8) {
                    TabButton(
                        title: "Nook",
                        icon: "lamp.desk.fill",
                        isSelected: selectedTab == .nook
                    ) {
                        selectedTab = .nook
                    }
                    
                    TabButton(
                        title: "Notes",
                        icon: "note.text",
                        isSelected: selectedTab == .notes
                    ) {
                        selectedTab = .notes
                    }
                    
                    TabButton(
                        title: "Tray",
                        icon: "tray.fill",
                        isSelected: selectedTab == .tray
                    ) {
                        selectedTab = .tray
                    }
                }
                
                Spacer()
                
                // Settings button
                Button(action: {
                    showSettings.toggle()
                }) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white.opacity(0.9))
                        .frame(width: 28, height: 28)
                        .background(Color.white.opacity(0.06))
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
                .help("Settings")
            }
            
            // Content area with smooth transition
            ZStack {
                switch selectedTab {
                case .nook:
                    NookContentView()
                        .environmentObject(fileShelfManager)
                        .environmentObject(settingsManager)
                        .transition(.asymmetric(
                            insertion: .move(edge: .leading).combined(with: .opacity),
                            removal: .move(edge: .trailing).combined(with: .opacity)
                        ))
                case .notes:
                    NotesView()
                        .environmentObject(notesManager)
                        .transition(.opacity)
                case .tray:
                    TrayContentView()
                        .environmentObject(fileShelfManager)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .animation(.easeInOut(duration: 0.3), value: selectedTab)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 14)
        .background(
            NotchMorphView()
        )
        .sheet(isPresented: $showSettings) {
            SettingsSheetView()
                .environmentObject(settingsManager)
        }
        .onAppear {
            registerWidgets()
        }
        .animation(.easeInOut(duration: 0.2), value: settingsManager.settings.transparency)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    private func registerWidgets() {
        widgetRegistry.register(ClockWidget())
        widgetRegistry.register(CalendarWidget())
        widgetRegistry.register(SystemInfoWidget())
        widgetRegistry.register(MediaControlWidget())
        widgetRegistry.loadConfigurations()
    }
}

struct TabButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 12, weight: .semibold))
                Text(title)
                    .font(.system(size: 12, weight: .semibold))
            }
            .foregroundColor(isSelected ? .white : .white.opacity(0.7))
            .padding(.horizontal, 14)
            .padding(.vertical, 7)
            .background(
                Capsule()
                    .fill(isSelected ? Color.white.opacity(0.18) : Color.white.opacity(0.08))
            )
        }
        .buttonStyle(.plain)
    }
}

struct NookContentView: View {
    @EnvironmentObject var fileShelfManager: FileShelfManager
    @EnvironmentObject var settingsManager: SettingsManager
    
    var body: some View {
        let showChatbot = settingsManager.settings.showChatbot
        let showClockCard = settingsManager.settings.showClockCard
        let showQuickLaunch = settingsManager.settings.showQuickLaunch
        let showMirror = settingsManager.settings.showMirror
        let showUtilities = showClockCard || showQuickLaunch
        let showFirstSeparator = showChatbot && (showUtilities || showMirror)
        let showSecondSeparator = showUtilities && showMirror
        
        HStack(alignment: .center, spacing: 18) {
            if showChatbot {
                ChatbotWidgetView()
                    .environmentObject(settingsManager)
            }
            
            if showFirstSeparator {
                verticalSeparator
            }
            
            if showUtilities {
                VStack(spacing: 10) {
                    if showClockCard {
                        ClockActionButton()
                    }
                    if showQuickLaunch {
                        QuickLaunchButton()
                            .environmentObject(settingsManager)
                    }
                }
            }
            
            if showSecondSeparator {
                verticalSeparator
            }
            
            if showMirror {
                MirrorControlView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
    }
    
    private var verticalSeparator: some View {
        Rectangle()
            .fill(Color.white.opacity(0.16))
            .frame(width: 1, height: 96)
            .padding(.horizontal, 4)
    }
}

struct ChatbotWidgetView: View {
    @EnvironmentObject var settingsManager: SettingsManager
    @StateObject private var chatModel = ChatbotModel()
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 6) {
                Image(systemName: "sparkles")
                    .foregroundColor(.yellow.opacity(0.9))
                Text("Chatbot")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white)
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    if chatModel.messages.isEmpty {
                        Text("Ask anything. Configure your API key in Settings.")
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.7))
                    } else {
                        ForEach(chatModel.messages) { message in
                            HStack {
                                if message.role == .assistant { Spacer() }
                                Text(message.content)
                                    .font(.system(size: 12))
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(
                                        Capsule(style: .continuous)
                                            .fill(message.role == .user ? Color.white.opacity(0.12) : Color.white.opacity(0.08))
                                    )
                                if message.role == .user { Spacer() }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(height: 82)
            
            if let error = chatModel.errorMessage {
                Text(error)
                    .font(.system(size: 11))
                    .foregroundColor(.red.opacity(0.85))
            }
            
            HStack(spacing: 8) {
                TextField("Message", text: $chatModel.input)
                    .focused($isInputFocused)
                    .textFieldStyle(.plain)
                    .foregroundColor(.white)
                    .tint(.white)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.08)))
                    .onSubmit {
                        chatModel.send(apiKey: settingsManager.settings.apiKey)
                    }
                    .submitLabel(.send)
                
                Button(action: {
                    chatModel.send(apiKey: settingsManager.settings.apiKey)
                    isInputFocused = true
                }) {
                    HStack(spacing: 6) {
                        if chatModel.isSending {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .scaleEffect(0.65)
                        } else {
                            Image(systemName: "paperplane.fill")
                                .font(.system(size: 14, weight: .semibold))
                            Text("Send")
                                .font(.system(size: 12, weight: .semibold))
                        }
                    }
                    .frame(minWidth: 64)
                }
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Capsule().fill(Color.white.opacity(0.14)))
                .buttonStyle(.plain)
                .disabled(chatModel.input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || chatModel.isSending)
            }
        }
        .padding(12)
        .frame(width: 260)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.white.opacity(0.06))
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(Color.white.opacity(0.05), lineWidth: 1)
                )
        )
        .onAppear {
            isInputFocused = true
        }
        .onTapGesture {
            isInputFocused = true
        }
    }
}

struct ClockActionButton: View {
    @State private var now = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "h:mm:ss a"
        return df
    }()
    private let dayFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d"
        return df
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(dateFormatter.string(from: now))
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
            Text(dayFormatter.string(from: now))
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white.opacity(0.75))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(width: 200, alignment: .leading)
        .background(
            Capsule()
                .fill(Color.white.opacity(0.12))
        )
        .overlay(
            Capsule()
                .stroke(Color.white.opacity(0.05), lineWidth: 1)
        )
        .onReceive(timer) { value in
            now = value
        }
    }
}

struct QuickLaunchButton: View {
    @EnvironmentObject var settingsManager: SettingsManager
    
    private var appDisplayName: String {
        let path = settingsManager.settings.quickLaunchAppPath.trimmingCharacters(in: .whitespacesAndNewlines)
        if path.isEmpty { return "Set app in Settings" }
        return URL(fileURLWithPath: path).deletingPathExtension().lastPathComponent
    }
    
    var body: some View {
        Button(action: openApp) {
            HStack(spacing: 8) {
                Image(systemName: "bolt.fill")
                    .font(.system(size: 13, weight: .semibold))
                Text(appDisplayName)
                    .font(.system(size: 12, weight: .semibold))
                    .lineLimit(1)
            }
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .frame(width: 200, alignment: .leading)
            .background(
                Capsule()
                    .fill(Color.white.opacity(0.12))
            )
            .overlay(
                Capsule()
                    .stroke(Color.white.opacity(0.05), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .disabled(settingsManager.settings.quickLaunchAppPath.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }
    
    private func openApp() {
        let trimmed = settingsManager.settings.quickLaunchAppPath.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        let url = URL(fileURLWithPath: trimmed)
        NSWorkspace.shared.openApplication(at: url, configuration: NSWorkspace.OpenConfiguration(), completionHandler: nil)
    }
}

struct MirrorControlView: View {
    @EnvironmentObject var windowManager: WindowManager
    @StateObject private var cameraModel = CameraMirrorModel()
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.16))
                
                if cameraModel.isAuthorized {
                    CameraPreview(session: cameraModel.session)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.12), lineWidth: 1)
                        )
                } else {
                    Image(systemName: "circle.viewfinder")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.white.opacity(0.6))
                }
            }
            .frame(width: 76, height: 76)
            .overlay(
                Circle()
                    .stroke(Color.white.opacity(0.08), lineWidth: 1)
            )
            .onAppear {
                if windowManager.isVisible {
                    cameraModel.start()
                }
            }
            .onChange(of: windowManager.isVisible) { _, isVisible in
                // Keep the camera in sync with the window being shown/hidden
                if isVisible {
                    cameraModel.start()
                } else {
                    cameraModel.stop()
                }
            }
            .onDisappear {
                cameraModel.stop()
            }
            
            Text("Mirror")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.white.opacity(0.7))
        }
    }
}

struct TrayContentView: View {
    @EnvironmentObject var fileShelfManager: FileShelfManager
    
    var body: some View {
        FileShelfView()
            .environmentObject(fileShelfManager)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct NotchMorphView: View {
    private let cornerRadius: CGFloat = 26
    
    var body: some View {
        let shape = NotchMorphShape(cornerRadius: cornerRadius)
        
        ZStack {
            shape
                .fill(Color.black)
        }
    }
}

struct NotchMorphShape: Shape {
    let cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let radius = min(cornerRadius, min(rect.width, rect.height) / 2)
        let rounded = RoundedRectangle(cornerRadius: radius, style: .continuous)
        return rounded.path(in: rect)
    }
}

struct VisualEffectView: NSViewRepresentable {
    let material: NSVisualEffectView.Material
    let blendingMode: NSVisualEffectView.BlendingMode
    
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = .underWindowBackground
        view.blendingMode = .behindWindow
        view.state = .active
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.7).cgColor
        return view
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        nsView.material = .underWindowBackground
        nsView.blendingMode = blendingMode
    }
}
