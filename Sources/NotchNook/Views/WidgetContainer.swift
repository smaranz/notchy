import SwiftUI

struct WidgetContainer: View {
    @EnvironmentObject var widgetRegistry: WidgetRegistry
    @EnvironmentObject var settingsManager: SettingsManager
    @State private var scrollOffset: CGFloat = 0
    
    var enabledWidgets: [any Widget] {
        widgetRegistry.getEnabledWidgets().filter { widget in
            switch widget.id {
            case "clock":
                return settingsManager.settings.showClock
            case "calendar":
                return settingsManager.settings.showCalendar
            case "systemInfo":
                return settingsManager.settings.showSystemInfo
            case "mediaControl":
                return settingsManager.settings.showMediaControls
            default:
                return true
            }
        }
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(Array(enabledWidgets.enumerated()), id: \.element.id) { index, widget in
                        widget.makeView()
                            .frame(width: 50, height: 50)
                            .id(index)
                    }
                }
                .padding(.horizontal, 4)
            }
            .frame(height: 50)
            .gesture(
                DragGesture(minimumDistance: 10)
                    .onChanged { value in
                        withAnimation(.interactiveSpring()) {
                            scrollOffset = value.translation.width * settingsManager.settings.gestureSensitivity
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            scrollOffset = 0
                        }
                    }
            )
        }
    }
}

