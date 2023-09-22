//
//  LoggerServiceAdapter.swift
//  
//
//  Created by Martin Dutra on 10/2/22.
//

import Foundation
import OSLog

/// The LoggerServiceAdapter class can be used componenetoutput logs to files in the device's filesystem
/// and to the Console (in real-time) when debugging
///
/// It implements LoggerService so it is meant to be used by Log as a plug-in that actually outputs to logs somewhere.
class LoggerServiceAdapter: LoggerService {

    var fileLoggerService: FileLoggerService
    var loggers = [String: Logger]()

    init(fileLoggerService: FileLoggerService) {
        self.fileLoggerService = fileLoggerService
    }

    var fileUrls: [URL] {
        fileLoggerService.fileUrls
    }

    func debug(_ string: String, sourceFile: String) {
        let message = "LOG:DEBUG: \(string)"
        fileLoggerService.debug(message)
        let osLogger = logger(for: sourceFile)
        osLogger.debug("\(string)")
    }

    func info(_ string: String, sourceFile: String) {
        let message = "LOG:INFO: \(string)"
        fileLoggerService.info(message)
        let osLogger = logger(for: sourceFile)
        osLogger.info("\(string)")
    }

    func optional(_ error: Error?, _ detail: String?, sourceFile: String) -> Bool {
        guard let error = error else {
            return false
        }
        let message = "LOG:ERROR:\(detail ?? "") \(error)"
        fileLoggerService.error(message)
        let osLogger = logger(for: sourceFile)
        osLogger.error("\(detail ?? "") \(error)")
        return true
    }

    func unexpected(_ reason: String, _ detail: String?, sourceFile: String) {
        let message = "LOG:UNEXPECTED:\(reason) \(detail ?? "")"
        fileLoggerService.error(message)
        let osLogger = logger(for: sourceFile)
        osLogger.error("\(reason) \(detail ?? "")")
    }

    func fatal(_ reason: String, _ detail: String?, sourceFile: String) {
        let message = "LOG:FATAL:\(reason) \(detail ?? "")"
        fileLoggerService.error(message)
        let osLogger = logger(for: sourceFile)
        osLogger.error("\(reason) \(detail ?? "")")
    }
    
    private func logger(for sourceFile: String) -> Logger {
        let className = (sourceFile as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
        if let logger = loggers[className] {
            return logger
        } else {
            let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: className)
            loggers[className] = logger
            return logger
        }
    }
}
