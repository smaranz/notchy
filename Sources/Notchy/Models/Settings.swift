import Foundation
import SwiftUI

class Settings: ObservableObject {
    @Published var transparency: Double = 0.9 {
        didSet { save() }
    }
    
    @Published var showClock: Bool = true {
        didSet { save() }
    }
    
    @Published var showCalendar: Bool = true {
        didSet { save() }
    }
    
    @Published var showSystemInfo: Bool = true {
        didSet { save() }
    }
    
    @Published var showMediaControls: Bool = true {
        didSet { save() }
    }
    
    @Published var showChatbot: Bool = true {
        didSet { save() }
    }
    
    @Published var showClockCard: Bool = true {
        didSet { save() }
    }
    
    @Published var showQuickLaunch: Bool = true {
        didSet { save() }
    }
    
    @Published var showMirror: Bool = true {
        didSet { save() }
    }
    
    @Published var gestureSensitivity: Double = 1.0 {
        didSet { save() }
    }
    
    @Published var autoStart: Bool = false {
        didSet { save() }
    }
    
    @Published var apiKey: String = "" {
        didSet { save() } // In-memory only; not persisted in UserDefaults
    }
    
    @Published var quickLaunchAppPath: String = "" {
        didSet { save() }
    }
    
    private let userDefaultsKey = "notchNookSettings"
    
    init() {
        load()
    }
    
    private func save() {
        let settingsDict: [String: Any] = [
            "transparency": transparency,
            "showClock": showClock,
            "showCalendar": showCalendar,
            "showSystemInfo": showSystemInfo,
            "showMediaControls": showMediaControls,
            "showChatbot": showChatbot,
            "showClockCard": showClockCard,
            "showQuickLaunch": showQuickLaunch,
            "showMirror": showMirror,
            "gestureSensitivity": gestureSensitivity,
            "autoStart": autoStart
        ]
        UserDefaults.standard.set(settingsDict, forKey: userDefaultsKey)
    }
    
    private func load() {
        if let settingsDict = UserDefaults.standard.dictionary(forKey: userDefaultsKey) {
            transparency = settingsDict["transparency"] as? Double ?? 0.9
            showClock = settingsDict["showClock"] as? Bool ?? true
            showCalendar = settingsDict["showCalendar"] as? Bool ?? true
            showSystemInfo = settingsDict["showSystemInfo"] as? Bool ?? true
            showMediaControls = settingsDict["showMediaControls"] as? Bool ?? true
            showChatbot = settingsDict["showChatbot"] as? Bool ?? true
            showClockCard = settingsDict["showClockCard"] as? Bool ?? true
            showQuickLaunch = settingsDict["showQuickLaunch"] as? Bool ?? true
            showMirror = settingsDict["showMirror"] as? Bool ?? true
            gestureSensitivity = settingsDict["gestureSensitivity"] as? Double ?? 1.0
            autoStart = settingsDict["autoStart"] as? Bool ?? false
            quickLaunchAppPath = settingsDict["quickLaunchAppPath"] as? String ?? ""
            
            // If an apiKey was ever stored, scrub it from persisted settings
            if settingsDict["apiKey"] != nil {
                var cleaned = settingsDict
                cleaned.removeValue(forKey: "apiKey")
                UserDefaults.standard.set(cleaned, forKey: userDefaultsKey)
            }
            
            apiKey = "" // keep in-memory only
        }
    }
}
