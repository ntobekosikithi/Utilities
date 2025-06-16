//
//  Logger.swift
//  Utilities
//
//  Created by Ntobeko Sikithi on 2025/06/15.
//

import Foundation
import OSLog

public protocol Logger: Sendable {
    func info(_ message: String, file: String, function: String, line: Int)
    func error(_ message: String, file: String, function: String, line: Int)
    func debug(_ message: String, file: String, function: String, line: Int)
}

public extension Logger {
    func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        info(message, file: file, function: function, line: line)
    }

    func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        error(message, file: file, function: function, line: line)
    }

    func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        debug(message, file: file, function: function, line: line)
    }
}

public final class LoggerImplementation: Logger {

    private let osLogger: OSLog
    
    public init(subsystem: String = "com.fitnessapp", category: String = "general") {
        self.osLogger = OSLog(subsystem: subsystem, category: category)
    }
    
    public func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let logMessage = formatMessage(message, file: file, function: function, line: line)
        os_log("%{public}@", log: osLogger, type: .info, logMessage)
    }
    
    public func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let logMessage = formatMessage(message, file: file, function: function, line: line)
        os_log("%{public}@", log: osLogger, type: .error, logMessage)
    }
    
    public func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let logMessage = formatMessage(message, file: file, function: function, line: line)
        os_log("%{public}@", log: osLogger, type: .debug, logMessage)
    }
    
    private func formatMessage(_ message: String, file: String, function: String, line: Int) -> String {
        let fileName = URL(fileURLWithPath: file).lastPathComponent
        return "[\(fileName):\(line)] \(function) - \(message)"
    }
}
