import Foundation
import AppKit

struct FileItem: Identifiable, Codable {
    var id: UUID
    var name: String
    var path: String
    var bookmarkData: Data?
    var addedDate: Date
    
    init(id: UUID = UUID(), name: String, path: String, bookmarkData: Data? = nil) {
        self.id = id
        self.name = name
        self.path = path
        self.bookmarkData = bookmarkData
        self.addedDate = Date()
    }
    
    var url: URL? {
        if let bookmarkData = bookmarkData {
            var isStale = false
            if let url = try? URL(
                resolvingBookmarkData: bookmarkData,
                options: .withoutUI,
                relativeTo: nil,
                bookmarkDataIsStale: &isStale
            ) {
                if !isStale {
                    return url
                }
            }
        }
        return URL(fileURLWithPath: path)
    }
    
    var icon: NSImage? {
        guard let url = url else { return nil }
        return NSWorkspace.shared.icon(forFile: url.path)
    }
    
    func createBookmark() -> Data? {
        guard let url = url else { return nil }
        return try? url.bookmarkData(
            options: .withSecurityScope,
            includingResourceValuesForKeys: nil,
            relativeTo: nil
        )
    }
}

class FileShelfManager: ObservableObject {
    @Published var files: [FileItem] = []
    
    private let userDefaultsKey = "fileShelfItems"
    
    init() {
        loadFiles()
    }
    
    func addFile(_ url: URL) {
        let fileItem = FileItem(
            name: url.lastPathComponent,
            path: url.path,
            bookmarkData: try? url.bookmarkData(
                options: .withSecurityScope,
                includingResourceValuesForKeys: nil,
                relativeTo: nil
            )
        )
        
        if !files.contains(where: { $0.path == fileItem.path }) {
            files.append(fileItem)
            saveFiles()
        }
    }
    
    func removeFile(_ fileItem: FileItem) {
        files.removeAll { $0.id == fileItem.id }
        saveFiles()
    }
    
    func openFile(_ fileItem: FileItem) {
        guard let url = fileItem.url else { return }
        NSWorkspace.shared.open(url)
    }
    
    private func saveFiles() {
        if let encoded = try? JSONEncoder().encode(files) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    private func loadFiles() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode([FileItem].self, from: data) {
            files = decoded
        }
    }
}
