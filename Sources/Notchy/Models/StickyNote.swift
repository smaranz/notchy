import Foundation
import SwiftUI

struct StickyNote: Identifiable, Codable, Equatable {
    var id: UUID
    var text: String
    var colorIndex: Int
    var createdAt: Date
    
    init(id: UUID = UUID(), text: String = "", colorIndex: Int = 0, createdAt: Date = Date()) {
        self.id = id
        self.text = text
        self.colorIndex = colorIndex
        self.createdAt = createdAt
    }
}

enum StickyNoteDefaults {
    static let paletteCount = 5
}

final class NotesManager: ObservableObject {
    @Published var notes: [StickyNote] = [] {
        didSet { saveNotes() }
    }
    
    private let userDefaultsKey = "stickyNotes"
    
    init() {
        loadNotes()
    }
    
    @discardableResult
    func addNote() -> StickyNote {
        let nextIndex = ((notes.first?.colorIndex ?? -1) + 1) % StickyNoteDefaults.paletteCount
        let note = StickyNote(text: "", colorIndex: max(0, nextIndex))
        notes.insert(note, at: 0)
        return note
    }
    
    func removeNote(_ note: StickyNote) {
        notes.removeAll { $0.id == note.id }
    }
    
    private func saveNotes() {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    private func loadNotes() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode([StickyNote].self, from: data) {
            notes = decoded
        }
    }
}
