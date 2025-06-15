//
//  Logger.swift
//  Utilities
//
//  Created by Ntobeko Sikithi on 2025/06/15.
//

import Foundation
import OSLog

public final class Logger: @unchecked Sendable {
    public static let shared = Logger()
    
    private let osLogger: OSLog
    
    private init() {
        self.osLogger = OSLog(subsystem: "com.fitnessapp", category: "general")
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
