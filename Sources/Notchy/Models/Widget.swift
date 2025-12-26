import SwiftUI
import Foundation

protocol Widget: Identifiable {
    var id: String { get }
    var name: String { get }
    var icon: String { get }
    var isEnabled: Bool { get set }
    
    func makeView() -> AnyView
}

struct WidgetConfiguration: Codable {
    var id: String
    var isEnabled: Bool
    var order: Int
}

// Widget Registry
class WidgetRegistry: ObservableObject {
    @Published var widgets: [any Widget] = []
    @Published var configurations: [WidgetConfiguration] = []
    
    func register(_ widget: any Widget) {
        if !widgets.contains(where: { $0.id == widget.id }) {
            widgets.append(widget)
            
            // Add default configuration if not exists
            if !configurations.contains(where: { $0.id == widget.id }) {
                configurations.append(WidgetConfiguration(
                    id: widget.id,
                    isEnabled: true,
                    order: configurations.count
                ))
            }
        }
    }
    
    func getEnabledWidgets() -> [any Widget] {
        return widgets
            .filter { widget in
                configurations.first(where: { $0.id == widget.id })?.isEnabled ?? true
            }
            .sorted { w1, w2 in
                let c1 = configurations.first(where: { $0.id == w1.id })?.order ?? 0
                let c2 = configurations.first(where: { $0.id == w2.id })?.order ?? 0
                return c1 < c2
            }
    }
    
    func saveConfigurations() {
        if let encoded = try? JSONEncoder().encode(configurations) {
            UserDefaults.standard.set(encoded, forKey: "widgetConfigurations")
        }
    }
    
    func loadConfigurations() {
        if let data = UserDefaults.standard.data(forKey: "widgetConfigurations"),
           let decoded = try? JSONDecoder().decode([WidgetConfiguration].self, from: data) {
            configurations = decoded
        }
    }
}

