import Foundation
import SwiftUI
import Combine

class SettingsManager: ObservableObject {
    @Published var settings = Settings()
    private var cancellable: AnyCancellable?
    
    init() {
        // Forward nested Settings object changes to SwiftUI
        cancellable = settings.objectWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
}
