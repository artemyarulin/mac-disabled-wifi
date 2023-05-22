import Foundation
import CoreWLAN

let wifiClient: CWInterface! = CWWiFiClient.shared().interface()

func enableWiFiFor(durationMinutes: Int) {
    setWiFiPower(power: true)
    DispatchQueue.main.asyncAfter(deadline: .now() + Double(durationMinutes) * 60) {
        setWiFiPower(power: false)
    }
}

func setWiFiPower(power: Bool) {
    // HACK Tests are crashing in CI environment if there is any WiFi power modifications, skip it
    if isRunningTests() { return }
        
    do {
        try wifiClient.setPower(power)
    } catch {
        print("Unexpected error: \(error).")
    }
}

// Hides/Shows standard WiFi top bar menu item
func setWiFiStatusButtonVisibility(visible: Bool) {
    // Command and magic numbers taken from https://superuser.com/a/1723655
    let code = visible ? 18 : 24
    runBashCommand(command: "defaults -currentHost write com.apple.controlcenter WiFi -int \(code)")
}
