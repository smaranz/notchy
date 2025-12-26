import Foundation
import AppKit

struct FileUtilities {
    static func getFileIcon(for url: URL) -> NSImage? {
        return NSWorkspace.shared.icon(forFile: url.path)
    }
    
    static func getFileSize(for url: URL) -> String? {
        guard let attributes = try? FileManager.default.attributesOfItem(atPath: url.path),
              let size = attributes[.size] as? Int64 else {
            return nil
        }
        
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useKB, .useMB, .useGB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: size)
    }
    
    static func getFileModificationDate(for url: URL) -> Date? {
        guard let attributes = try? FileManager.default.attributesOfItem(atPath: url.path),
              let modificationDate = attributes[.modificationDate] as? Date else {
            return nil
        }
        return modificationDate
    }
    
    static func isFileAccessible(at url: URL) -> Bool {
        return FileManager.default.fileExists(atPath: url.path)
    }
    
    static func resolveBookmark(_ bookmarkData: Data) -> URL? {
        var isStale = false
        do {
            let url = try URL(
                resolvingBookmarkData: bookmarkData,
                options: .withoutUI,
                relativeTo: nil,
                bookmarkDataIsStale: &isStale
            )
            return isStale ? nil : url
        } catch {
            return nil
        }
    }
}

