import SwiftUI

struct ClockWidget: Widget {
    var id: String { "clock" }
    var name: String { "Clock" }
    var icon: String { "clock.fill" }
    var isEnabled: Bool = true
    
    @State private var currentTime = Date()
    
    func makeView() -> AnyView {
        AnyView(ClockWidgetView())
    }
}

struct ClockWidgetView: View {
    @State private var currentTime = Date()
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 2) {
            Text(timeString)
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundColor(.primary)
            
            Text(dateString)
                .font(.system(size: 8))
                .foregroundColor(.secondary)
        }
        .frame(width: 50, height: 50)
        .onReceive(timer) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                currentTime = Date()
            }
        }
    }
    
    private var timeString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: currentTime)
    }
    
    private var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: currentTime)
    }
}

