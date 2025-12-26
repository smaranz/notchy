import SwiftUI
import AppKit
import UniformTypeIdentifiers

struct SettingsView: View {
    @EnvironmentObject var settingsManager: SettingsManager
    
    var body: some View {
        VStack {
            TabView {
                GeneralSettingsView()
                    .environmentObject(settingsManager)
                    .tabItem {
                        Label("General", systemImage: "gear")
                    }
                
            NookSettingsView()
                .environmentObject(settingsManager)
                .tabItem {
                    Label("Nook", systemImage: "rectangle.3.offgrid")
                }
                
                AppearanceSettingsView()
                    .environmentObject(settingsManager)
                    .tabItem {
                        Label("Appearance", systemImage: "paintbrush")
                    }
                
                ChatbotSettingsView()
                    .environmentObject(settingsManager)
                    .tabItem {
                        Label("Chatbot", systemImage: "message")
                    }
            }
            .tabViewStyle(.automatic)
            .padding(16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct GeneralSettingsView: View {
    @EnvironmentObject var settingsManager: SettingsManager
    
    private var selectedAppName: String {
        let path = settingsManager.settings.quickLaunchAppPath
        if path.isEmpty { return "Select an application" }
        return URL(fileURLWithPath: path).deletingPathExtension().lastPathComponent
    }
    
    var body: some View {
        Form {
            Section("General") {
                Toggle("Launch at Login", isOn: $settingsManager.settings.autoStart)
            }
            
            Section("Quick Launch") {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(selectedAppName)
                            .font(.system(size: 13, weight: .semibold))
                        Text(settingsManager.settings.quickLaunchAppPath.isEmpty ? "No app selected" : settingsManager.settings.quickLaunchAppPath)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                    Spacer()
                    Button("Choose App…") {
                        chooseApp()
                    }
                    .buttonStyle(.borderedProminent)
                }
                Text("Set the app to open from the Quick Launch button in Notchy.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Section("Gestures") {
                VStack(alignment: .leading) {
                    Text("Gesture Sensitivity")
                    Slider(value: $settingsManager.settings.gestureSensitivity, in: 0.5...2.0)
                    Text("\(settingsManager.settings.gestureSensitivity, specifier: "%.1f")x")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
    }
    
    private func chooseApp() {
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowsMultipleSelection = false
        panel.allowedContentTypes = [.application]
        panel.level = .modalPanel
        NSApp.activate(ignoringOtherApps: true)
        panel.orderFrontRegardless()
        panel.begin { response in
            if response == .OK, let url = panel.url {
                settingsManager.settings.quickLaunchAppPath = url.path
            }
        }
    }
}

struct ChatbotSettingsView: View {
    @EnvironmentObject var settingsManager: SettingsManager
    @State private var isKeyVisible = false
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        Form {
            Section("API Key") {
                HStack {
                    Group {
                        if isKeyVisible {
                            TextField("Enter API key", text: $settingsManager.settings.apiKey)
                                .textFieldStyle(.roundedBorder)
                                .frame(maxWidth: 320)
                                .focused($isTextFieldFocused)
                        } else {
                            SecureField("Enter API key", text: $settingsManager.settings.apiKey)
                                .textFieldStyle(.roundedBorder)
                                .frame(maxWidth: 320)
                                .focused($isTextFieldFocused)
                        }
                    }
                    .onPasteCommand(of: [.text]) { providers in
                        handlePaste(providers: providers)
                    }
                    
                    Button(action: { 
                        pasteFromClipboard()
                    }) {
                        Image(systemName: "doc.on.clipboard")
                            .font(.system(size: 12))
                    }
                    .buttonStyle(.borderless)
                    .help("Paste from clipboard")
                    
                    Button(action: { isKeyVisible.toggle() }) {
                        Image(systemName: isKeyVisible ? "eye.slash" : "eye")
                    }
                    .buttonStyle(.borderless)
                    .help(isKeyVisible ? "Hide key" : "Show key")
                    
                    Button(action: { settingsManager.settings.apiKey = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 12))
                    }
                    .buttonStyle(.borderless)
                    .help("Clear key")
                }
                Text("Stored locally. Required for GPT-5-Nano requests. Not included in the repo.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .formStyle(.grouped)
    }
    
    private func handlePaste(providers: [NSItemProvider]) {
        for provider in providers {
            if provider.hasItemConformingToTypeIdentifier("public.plain-text") {
                provider.loadItem(forTypeIdentifier: "public.plain-text", options: nil) { item, error in
                    if let data = item as? Data, let text = String(data: data, encoding: .utf8) {
                        DispatchQueue.main.async {
                            settingsManager.settings.apiKey = text.trimmingCharacters(in: .whitespacesAndNewlines)
                        }
                    } else if let text = item as? String {
                        DispatchQueue.main.async {
                            settingsManager.settings.apiKey = text.trimmingCharacters(in: .whitespacesAndNewlines)
                        }
                    }
                }
            }
        }
    }
    
    private func pasteFromClipboard() {
        let pasteboard = NSPasteboard.general
        if let string = pasteboard.string(forType: .string) {
            settingsManager.settings.apiKey = string.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}

struct SettingsSheetView: View {
    @EnvironmentObject var settingsManager: SettingsManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                        .padding(6)
                        .background(Circle().fill(Color.white.opacity(0.15)))
                }
                .buttonStyle(.plain)
                .help("Close")
                
                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.top, 12)
            .padding(.bottom, 6)
            
            Divider()
                .background(Color.white.opacity(0.1))
            
            SettingsView()
                .environmentObject(settingsManager)
        }
        .frame(minWidth: 560, minHeight: 480)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
                )
        )
        .padding(12)
    }
}

struct NookSettingsView: View {
    @EnvironmentObject var settingsManager: SettingsManager
    
    var body: some View {
        Form {
            Section("Nook Widgets") {
                Toggle("Chatbot", isOn: $settingsManager.settings.showChatbot)
                Toggle("Clock + Date", isOn: $settingsManager.settings.showClockCard)
                Toggle("Quick Launch", isOn: $settingsManager.settings.showQuickLaunch)
                Toggle("Mirror", isOn: $settingsManager.settings.showMirror)
            }
        }
        .padding()
    }
}

struct AppearanceSettingsView: View {
    @EnvironmentObject var settingsManager: SettingsManager
    
    var body: some View {
        Form {
            Section("Appearance") {
                VStack(alignment: .leading) {
                    Text("Transparency")
                    Slider(value: $settingsManager.settings.transparency, in: 0.5...1.0)
                    Text("\(Int(settingsManager.settings.transparency * 100))%")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
    }
}
