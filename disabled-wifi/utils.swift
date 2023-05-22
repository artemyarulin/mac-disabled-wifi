import Foundation

// Returns true if apps runs under tests
public func isRunningTests() -> Bool {
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
