// Disable changes after enable time expired for 5 minutes
// Register as LoginItem
// Protect from quitting
// When WiFi is enabled manually - which option it is?
// On LapTop started/Lid open
// Monitor WiFi changes https://developer.apple.com/forums/thread/11307

import SwiftUI

let wifiIconEnabled = "wifi"
let wifiIconDisabled = "wifi.slash"

@main
struct disabled_wifiApp: App {
    @State private var timer: Timer?
    @State private var enabledTill: Date?
    @State private var enabledFor: String?
    @State private var menuIcon: String = wifiIconDisabled
    
    init() {
        NSApplication.shared.setActivationPolicy(.accessory) // Hide from Cmd+Tab
        setWiFiPower(power: false)
        setWiFiStatusButtonVisibility(visible: false)
    }
    
    func switchWiFiOnFor(durationMinutes: Int) {
        menuIcon = wifiIconEnabled
        enabledTill = Date().addingTimeInterval(TimeInterval(durationMinutes * 60))
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {_ in
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.minute, .hour, .second]
            formatter.unitsStyle = .abbreviated
            let elapsedTime = Calendar.current.dateComponents([.minute, .hour, .second], from: Date(), to: enabledTill!)
            let timeLeft = formatter.string(from: elapsedTime) ?? ""
            enabledFor = "\(timeLeft) left. Stop now"
        }
        enableWiFiFor(durationMinutes: durationMinutes) {
            menuIcon = wifiIconDisabled
            timer?.invalidate()
        }
    }
    
    func buttons() -> AnyView {
        if menuIcon == wifiIconEnabled {
            var body: some View {
                VStack {
                    Button(enabledFor ?? "Disabled") {
                        setWiFiPower(power: false)
                        menuIcon = wifiIconDisabled
                    }
                    Button("Exit") {
                        setWiFiPower(power: true)
                        setWiFiStatusButtonVisibility(visible: true)
                        exit(0)
                    }
                }
            }
            return AnyView(body)
        }
        var body: some View {
            VStack {
                Button("Enable for 1 minute") {
                    switchWiFiOnFor(durationMinutes: 1)
                }
                Button("Enable for 30 minutes") {
                    switchWiFiOnFor(durationMinutes: 30)
                }
                Button("Enable for 2 hours") {
                    switchWiFiOnFor(durationMinutes: 120)
                }
                Button("Exit") {
                    setWiFiPower(power: true)
                    setWiFiStatusButtonVisibility(visible: true)
                    exit(0)
                }
            }
        }
        return AnyView(body)
    }
    
    var body: some Scene {
        MenuBarExtra("", systemImage: menuIcon) {
            buttons()
        }
    }
}
