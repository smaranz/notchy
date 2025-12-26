import SwiftUI
import AppKit

class GestureRecognizer: ObservableObject {
    @Published var horizontalSwipe: CGFloat = 0
    @Published var verticalSwipe: CGFloat = 0
    @Published var isDragging = false
    
    var sensitivity: Double = 1.0
    
    func handleDragGesture(_ value: DragGesture.Value) {
        let translation = value.translation
        horizontalSwipe = translation.width * sensitivity
        verticalSwipe = translation.height * sensitivity
        isDragging = !value.translation.width.isZero || !value.translation.height.isZero
    }
    
    func reset() {
        horizontalSwipe = 0
        verticalSwipe = 0
        isDragging = false
    }
}

extension View {
    func notchGesture(recognizer: GestureRecognizer) -> some View {
        self.gesture(
            DragGesture(minimumDistance: 10)
                .onChanged { value in
                    recognizer.handleDragGesture(value)
                }
                .onEnded { _ in
                    recognizer.reset()
                }
        )
    }
}

