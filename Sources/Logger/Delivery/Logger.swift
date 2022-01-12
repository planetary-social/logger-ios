//
//  Logger.swift
//  
//
//  Created by Martin Dutra on 22/11/21.
//

import Foundation

public class Logger {

    public enum Reason: String {
        case apiError
        case botError
        case missingValue
        case incorrectValue
    }

    public static let shared = Logger()

    var service: LoggerService

    init(service: LoggerService = LoggerServiceAdapter(fileLoggerService: CocoaLumberjackService())) {
        self.service = service
    }

    public var fileUrls: [URL] {
        return service.fileUrls
    }

    @discardableResult
    public func optional(_ error: Error?, _ detail: String? = nil) -> Bool {
        service.optional(error, detail)
    }

    public func info(_ string: String) {
        service.info(string)
    }

    public func debug(_ string: String) {
        service.debug(string)
    }

    public func unexpected(_ reason: Reason, _ detail: String?) {
        service.unexpected(reason.rawValue, detail)
    }

    public func fatal(_ reason: Reason, _ detail: String?) {
        service.fatal(reason.rawValue, detail)
    }

}
