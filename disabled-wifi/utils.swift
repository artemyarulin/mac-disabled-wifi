import Foundation

// Returns true if apps runs under tests
func isRunningTests() -> Bool {
    let environment = ProcessInfo.processInfo.environment
    return environment["XCTestConfigurationFilePath"] != nil
}

// Run bash command and prints stdout in case of non zero exit code
func runBashCommand(command: String) {
    let process = Process()
    process.launchPath = "/bin/bash"
    process.arguments = ["-c", command]
    let pipe = Pipe()
    process.standardOutput = pipe
    process.launch()
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .newlines)
    process.waitUntilExit()

    let status = process.terminationStatus
    if status != 0 {
        print("Command failed with exit code: \(status)\n\(String(describing: output))")
    }
}

// Runs command which logsout current user
func logout() {
    runBashCommand(command: "launchctl bootout gui/$(id -u $(whoami))")
}

func formatTimeLeft(tillDate: Date) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.minute, .hour, .second]
    formatter.unitsStyle = .abbreviated
    let elapsedTime = Calendar.current.dateComponents([.minute, .hour, .second], from: Date(), to: tillDate)
    return formatter.string(from: elapsedTime) ?? ""
}
