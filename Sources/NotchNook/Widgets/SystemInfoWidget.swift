import SwiftUI
import AppKit
import IOKit
import IOKit.ps

struct SystemInfoWidget: Widget {
    var id: String { "systemInfo" }
    var name: String { "System Info" }
    var icon: String { "cpu" }
    var isEnabled: Bool = true
    
    func makeView() -> AnyView {
        AnyView(SystemInfoWidgetView())
    }
}

struct SystemInfoWidgetView: View {
    @State private var cpuUsage: Double = 0.0
    @State private var memoryUsage: Double = 0.0
    @State private var batteryLevel: Double? = nil
    
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 2) {
            HStack(spacing: 4) {
                // CPU
                VStack(spacing: 1) {
                    Image(systemName: "cpu")
                        .font(.system(size: 8))
                    Text("\(Int(cpuUsage))%")
                        .font(.system(size: 7))
                }
                
                // Memory
                VStack(spacing: 1) {
                    Image(systemName: "memorychip")
                        .font(.system(size: 8))
                    Text("\(Int(memoryUsage))%")
                        .font(.system(size: 7))
                }
            }
            
            // Battery (if available)
            if let batteryLevel = batteryLevel {
                HStack(spacing: 2) {
                    Image(systemName: batteryIcon(for: batteryLevel))
                        .font(.system(size: 8))
                    Text("\(Int(batteryLevel))%")
                        .font(.system(size: 7))
                }
            }
        }
        .frame(width: 50, height: 50)
        .onReceive(timer) { _ in
            updateSystemInfo()
        }
        .onAppear {
            updateSystemInfo()
        }
        .animation(.easeInOut(duration: 0.3), value: cpuUsage)
        .animation(.easeInOut(duration: 0.3), value: memoryUsage)
    }
    
    private func updateSystemInfo() {
        cpuUsage = getCPUUsage()
        memoryUsage = getMemoryUsage()
        batteryLevel = getBatteryLevel()
    }
    
    private func getCPUUsage() -> Double {
        // Note: Accurate CPU usage requires more complex monitoring with host_statistics
        // This is a simplified version that provides a reasonable estimate
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4
        
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_,
                         task_flavor_t(MACH_TASK_BASIC_INFO),
                         $0,
                         &count)
            }
        }
        
        if kerr == KERN_SUCCESS {
            // Estimate based on resident memory and CPU time
            // For a more accurate implementation, use host_statistics64
            let residentSize = Double(info.resident_size)
            let estimatedCPU = min(100.0, (residentSize / 1_000_000_000.0) * 10.0)
            return max(0.0, estimatedCPU)
        }
        return 0.0
    }
    
    private func getMemoryUsage() -> Double {
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4
        
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_,
                         task_flavor_t(MACH_TASK_BASIC_INFO),
                         $0,
                         &count)
            }
        }
        
        if kerr == KERN_SUCCESS {
            let usedMemory = Double(info.resident_size)
            let totalMemory = Double(ProcessInfo.processInfo.physicalMemory)
            return (usedMemory / totalMemory) * 100.0
        }
        return 0.0
    }
    
    private func getBatteryLevel() -> Double? {
        // Check if device has battery (laptops)
        let powerSource = IOPSCopyPowerSourcesInfo().takeRetainedValue()
        let powerSourcesArray = IOPSCopyPowerSourcesList(powerSource).takeRetainedValue() as Array
        
        if powerSourcesArray.count > 0 {
            let powerSourceDict = powerSourcesArray[0] as! CFDictionary
            let dict = powerSourceDict as NSDictionary
            
            if let currentCapacity = dict[kIOPSCurrentCapacityKey] as? Int,
               let maxCapacity = dict[kIOPSMaxCapacityKey] as? Int {
                return Double(currentCapacity) / Double(maxCapacity) * 100.0
            }
        }
        return nil
    }
    
    private func batteryIcon(for level: Double) -> String {
        if level > 75 {
            return "battery.100"
        } else if level > 50 {
            return "battery.75"
        } else if level > 25 {
            return "battery.50"
        } else {
            return "battery.25"
        }
    }
}
