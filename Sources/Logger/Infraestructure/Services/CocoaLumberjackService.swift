//
//  CocoaLumberjackService.swift
//  
//
//  Created by Martin Dutra on 22/11/21.
//

import Foundation
import CocoaLumberjack
import os.log

class CocoaLumberjackService: LoggerService {

    private var fileLogger: DDFileLogger

    var fileUrls: [URL] {
        return fileLogger.logFileManager.sortedLogFilePaths.map { URL(fileURLWithPath: $0) }
    }

    init() {
        fileLogger = DDFileLogger()
        fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }

    func optional(_ error: Error?, _ detail: String?) -> Bool {
        guard let error = error else { return false }
        let string = "LOG:ERROR:\(detail ?? "") \(error)"
        os_log("%@", type: OSLogType.error, string)
        // DDLogError(string)
        return true
    }

    func info(_ string: String) {
        // DDLogInfo(string)
        let message = "LOG:INFO: \(string)"
        os_log("%@", type: OSLogType.info, message)
    }

    func debug(_ string: String) {
        // DDLogDebug(string)
        let message = "LOG:DEBUG: \(string)"
        os_log("%@", type: OSLogType.debug, message)
    }

    func unexpected(_ reason: String, _ detail: String?) {
        let string = "\(reason) \(detail ?? "")"
        // DDLogError(string)
        let message = "LOG:UNEXPECTED:\(string)"
        os_log("%@", type: OSLogType.error, message)
    }

    func fatal(_ reason: String, _ detail: String?) {
        let string = "\(reason) \(detail ?? "")"
        // DDLogError(string)
        let message = "LOG:FATAL:\(string)"
        os_log("%@", type: OSLogType.fault, message)
    }

}
