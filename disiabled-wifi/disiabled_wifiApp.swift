// Disable on start
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
import CoreWLAN

@main
struct disiabled_wifiApp: App {
    
    fileprivate func enableWiFi(sleepMinutes: Int) {
        let wifiClient: CWInterface! = CWWiFiClient.shared().interface()
        
        do {
            try wifiClient.setPower(true)
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(sleepMinutes) * 60) {
                do {
                    try wifiClient.setPower(false)
                } catch {
                    print("Unexpected error: \(error).")
                }
            }
        } catch {
            print("Unexpected error: \(error).")
        }
    }
    
    var body: some Scene {
        MenuBarExtra("", systemImage: "wifi.router") {
            Button("Enable for 1 minute") {
                enableWiFi(sleepMinutes: 1)
            }
            Button("Enable for 10 minutes") {
                enableWiFi(sleepMinutes: 10)
            }
            Button("Enable for 30 minutes") {
                enableWiFi(sleepMinutes: 30)
            }
            Button("Enable for 2 hours") {
                enableWiFi(sleepMinutes: 120)
            }
            Button("Exit") {
                exit(0)
            }
        }
    }
}
