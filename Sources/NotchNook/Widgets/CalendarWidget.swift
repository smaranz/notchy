import SwiftUI

struct CalendarWidget: Widget {
    var id: String { "calendar" }
    var name: String { "Calendar" }
    var icon: String { "calendar" }
    var isEnabled: Bool = true
    
    func makeView() -> AnyView {
        AnyView(CalendarWidgetView())
    }
}

struct CalendarWidgetView: View {
    private let calendar = Calendar.current
    private let today = Date()
    
    var body: some View {
        VStack(spacing: 2) {
            Text(monthString)
                .font(.system(size: 8, weight: .semibold))
                .foregroundColor(.primary)
            
            Text(dayString)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
            
            Text(weekdayString)
                .font(.system(size: 7))
                .foregroundColor(.secondary)
        }
        .frame(width: 50, height: 50)
    }
    
    private var monthString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: today).uppercased()
    }
    
    private var dayString: String {
        let day = calendar.component(.day, from: today)
        return String(day)
    }
    
    private var weekdayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: today).uppercased()
    }
}

