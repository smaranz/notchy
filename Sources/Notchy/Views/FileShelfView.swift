import SwiftUI
import AppKit
import UniformTypeIdentifiers

struct FileShelfView: View {
    @EnvironmentObject var fileShelfManager: FileShelfManager
    @State private var isDragging = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 6) {
                    ForEach(fileShelfManager.files) { fileItem in
                        FileItemView(fileItem: fileItem)
                            .environmentObject(fileShelfManager)
                    }
                }
                .padding(.horizontal, 6)
                .padding(.top, 12)
            }
            
            if fileShelfManager.files.isEmpty {
                VStack {
                    Spacer()
                    Text("Drop files here")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white.opacity(0.7))
                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .onDrop(of: [.fileURL, .image], isTargeted: $isDragging) { providers in
            handleDrop(providers: providers)
        }
    }
    
    private func handleDrop(providers: [NSItemProvider]) -> Bool {
        var handled = false
        
        for provider in providers {
            if provider.hasItemConformingToTypeIdentifier(UTType.fileURL.identifier) {
                provider.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { item, error in
                    if let error = error {
                        print("Error loading file: \(error.localizedDescription)")
                        return
                    }
                    
                    if let data = item as? Data,
                       let url = URL(dataRepresentation: data, relativeTo: nil) {
                        DispatchQueue.main.async {
                            fileShelfManager.addFile(url)
                            handled = true
                        }
                    } else if let url = item as? URL {
                        DispatchQueue.main.async {
                            fileShelfManager.addFile(url)
                            handled = true
                        }
                    }
                }
            } else if provider.canLoadObject(ofClass: NSImage.self) {
                provider.loadObject(ofClass: NSImage.self) { object, _ in
                    guard let image = object as? NSImage,
                          let tempURL = saveTempImage(image: image) else { return }
                    DispatchQueue.main.async {
                        fileShelfManager.addFile(tempURL)
                        handled = true
                    }
                }
            }
        }
        
        return handled
    }
    
    private func saveTempImage(image: NSImage) -> URL? {
        guard let tiff = image.tiffRepresentation,
              let bitmap = NSBitmapImageRep(data: tiff),
              let data = bitmap.representation(using: .png, properties: [:]) else { return nil }
        
        let filename = "NotchTray-\(UUID().uuidString.prefix(8)).png"
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(filename)
        do {
            try data.write(to: url)
            return url
        } catch {
            print("Failed to save temp image: \(error)")
            return nil
        }
    }
}

struct FileItemView: View {
    let fileItem: FileItem
    @EnvironmentObject var fileShelfManager: FileShelfManager
    @State private var isHovered = false
    
    var body: some View {
        Button(action: {
            fileShelfManager.openFile(fileItem)
        }) {
            VStack(spacing: 2) {
                if let icon = fileItem.icon {
                    Image(nsImage: icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32)
                } else {
                    Image(systemName: "doc")
                        .font(.system(size: 24))
                        .foregroundColor(.secondary)
                }
                
                Text(fileItem.name)
                    .font(.system(size: 8))
                    .lineLimit(1)
                    .truncationMode(.middle)
                    .frame(maxWidth: 40)
            }
            .frame(width: 44, height: 44)
            .background(isHovered ? Color.primary.opacity(0.1) : Color.clear)
            .cornerRadius(4)
            .animation(.easeInOut(duration: 0.15), value: isHovered)
        }
        .buttonStyle(.plain)
        .onHover { hovering in
            isHovered = hovering
        }
        .onDrag {
            guard let url = fileItem.url else {
                return NSItemProvider()
            }
            return NSItemProvider(object: url as NSURL)
        }
        .contextMenu {
            Button("Remove") {
                fileShelfManager.removeFile(fileItem)
            }
        }
    }
}
