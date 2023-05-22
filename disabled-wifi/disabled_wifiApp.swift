// Timer to check current state
// Render current state - Enabled for X minutes / Locked for 5 minutes / Enable options
// Disable changes after enable time expired for 5 minutes
// Register as LoginItem
// Protect from quitting
// When WiFi is enabled manually - which option it is?
// On LapTop started/Lid open
// Monitor WiFi changes https://developer.apple.com/forums/thread/11307
// Hide WiFi?

import SwiftUI

@main
struct disabled_wifiApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    class AppDelegate: NSObject, NSApplicationDelegate {
        func applicationDidFinishLaunching(_ notification: Notification) {
            NSApplication.shared.setActivationPolicy(.accessory) // Hide from Cmd+Tab
            print("Hello, I'm disabling WiFi")
            setWiFiPower(power: false)
        }
    }
        
    var body: some Scene {
        MenuBarExtra("", systemImage: "wifi.router") {
            Button("Enable for 1 minute") {
                enableWiFiFor(durationMinutes: 1)
            }
            Button("Enable for 10 minutes") {
                enableWiFiFor(durationMinutes: 10)
            }
            Button("Enable for 30 minutes") {
                enableWiFiFor(durationMinutes: 30)
            }
            Button("Enable for 2 hours") {
                enableWiFiFor(durationMinutes: 120)
            }
            Button("Exit") {
                exit(0)
            }
        }
    }
}
