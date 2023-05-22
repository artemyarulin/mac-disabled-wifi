import Foundation

// Returns true if apps runs under tests
public func isRunningTests() -> Bool {
    let environment = ProcessInfo.processInfo.environment
    return environment["XCTestConfigurationFilePath"] != nil
}
