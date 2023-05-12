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
//    do {
//        try wifiClient.setPower(power)
//    } catch {
//        print("Unexpected error: \(error).")
//    }
}
