import SwiftUI

struct NotesView: View {
    @EnvironmentObject var notesManager: NotesManager
    @FocusState private var focusedNoteID: UUID?
    
    private let noteSize = CGSize(width: 168, height: 118)
    private let noteColors: [Color] = [
        Color(red: 0.98, green: 0.93, blue: 0.64),
        Color(red: 0.78, green: 0.94, blue: 0.85),
        Color(red: 0.78, green: 0.88, blue: 0.99),
        Color(red: 0.99, green: 0.85, blue: 0.75),
        Color(red: 0.97, green: 0.80, blue: 0.86)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Notes")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white.opacity(0.9))
                
                Spacer()
                
                Button(action: addNoteAndFocus) {
                    HStack(spacing: 6) {
                        Image(systemName: "plus")
                            .font(.system(size: 12, weight: .bold))
                        Text("New")
                            .font(.system(size: 12, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(Color.white.opacity(0.12))
                    )
                }
                .buttonStyle(.plain)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach($notesManager.notes) { $note in
                        StickyNoteCard(
                            note: $note,
                            color: noteColors[note.colorIndex % noteColors.count],
                            noteSize: noteSize,
                            focusedNoteID: $focusedNoteID
                        ) {
                            notesManager.removeNote(note)
                        }
                    }
                    
                    Button(action: addNoteAndFocus) {
                        VStack(spacing: 6) {
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 18, weight: .semibold))
                            Text("Add note")
                                .font(.system(size: 11, weight: .semibold))
                        }
                        .foregroundColor(.white.opacity(0.8))
                        .frame(width: noteSize.width, height: noteSize.height)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .strokeBorder(Color.white.opacity(0.16), style: StrokeStyle(lineWidth: 1, dash: [4, 4]))
                        )
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
            }
            
            if notesManager.notes.isEmpty {
                Text("Add a sticky note to capture quick thoughts.")
                    .font(.system(size: 11))
                    .foregroundColor(.white.opacity(0.6))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    private func addNoteAndFocus() {
        let note = notesManager.addNote()
        focusedNoteID = note.id
    }
}

private struct StickyNoteCard: View {
    @Binding var note: StickyNote
    let color: Color
    let noteSize: CGSize
    @FocusState.Binding var focusedNoteID: UUID?
    let onDelete: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .topLeading) {
                TextEditor(text: $note.text)
                    .focused($focusedNoteID, equals: note.id)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.black.opacity(0.82))
                    .tint(.black.opacity(0.7))
                    .padding(8)
                    .scrollContentBackground(.hidden)
                
                if note.text.isEmpty {
                    Text("Write a note...")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.black.opacity(0.35))
                        .padding(.top, 12)
                        .padding(.leading, 12)
                        .allowsHitTesting(false)
                }
            }
            
            Button(action: onDelete) {
                Image(systemName: "xmark")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.black.opacity(0.6))
                    .padding(6)
                    .background(
                        Circle()
                            .fill(Color.black.opacity(0.08))
                    )
            }
            .buttonStyle(.plain)
            .padding(6)
        }
        .frame(width: noteSize.width, height: noteSize.height)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [color.opacity(0.95), color.opacity(0.85)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(Color.black.opacity(0.08), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.18), radius: 6, x: 0, y: 3)
        .contextMenu {
            Button("Delete") {
                onDelete()
            }
        }
    }
}
