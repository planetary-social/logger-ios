//
//  Log.swift
//  
//
//  Created by Martin Dutra on 10/2/22.
//

import Foundation

/// The Log class provides a simple logging utility that you can use to output messages
///
/// The levels are as follows:
/// - FATAL: An unhandleable error that results in a program crash.
/// - ERROR or UNEXPECTED: A handleable error condition.
/// - INFO:  Generic (useful) information about system operation.
/// - DEBUG: Low-level information for developers.
public class Log: LogProtocol {

    public static let shared = Log()

    var service: LoggerService

    init(service: LoggerService = LoggerServiceAdapter(fileLoggerService: CocoaLumberjackService())) {
        self.service = service
    }

    public var fileUrls: [URL] {
        service.fileUrls
    }

    @discardableResult
    public func optional(_ error: Error?, _ detail: String? = nil, component: String = #file) -> Bool {
        service.optional(error, detail, component: component)
    }

    public func info(_ string: String, component: String = #file) {
        service.info(string, component: component)
    }

    public func debug(_ string: String, component: String = #file) {
        service.debug(string, component: component)
    }

    public func error(_ string: String, component: String = #file) {
        service.unexpected(string, nil, component: component)
    }

    public func unexpected(_ reason: Reason, _ detail: String?, component: String = #file) {
        service.unexpected(reason.rawValue, detail, component: component)
    }

    public func fatal(_ reason: Reason, _ detail: String?, component: String = #file) {
        service.fatal(reason.rawValue, detail, component: component)
    }
}

public extension Log {

    /// URLs in the device's filesystem that contain what was logged in this and previous sessions
    static var fileUrls: [URL] {
        shared.fileUrls
    }

    /// Log a ERROR message
    /// - Returns: True if an error could be unwrapped
    ///
    /// Convenience function that unwraps the error (if exists) and logs its description
    @discardableResult
    static func optional(_ error: Error?, _ detail: String? = nil, component: String = #file) -> Bool {
        shared.optional(error, detail, component: component)
    }

    /// Log a INFO message
    static func info(_ string: String, component: String = #file) {
        shared.info(string, component: component)
    }

    /// Log a DEBUG message
    static func debug(_ string: String, component: String = #file) {
        shared.debug(string, component: component)
    }

    /// Log a ERROR message
    ///
    /// Convencience function that categorize common errors that the app can handle
    static func unexpected(_ reason: Reason, _ detail: String?, component: String = #file) {
        shared.unexpected(reason, detail, component: component)
    }

    /// Log a FATAL message
    ///
    /// Convencience function that categorize common errors that the app cannot handle
    static func fatal(_ reason: Reason, _ detail: String?, component: String = #file) {
        shared.fatal(reason, detail, component: component)
    }

    /// Log a ERROR message
    ///
    /// Convenience function that unwraps an error and a response from a network call
    static func optional(_ error: Error?, from response: URLResponse?, component: String = #file) {
        guard let error = error else { return }
        guard let response = response else { return }
        let path = response.url?.path ?? "unknown path"
        let detail = "\(path) \(error)"
        shared.unexpected(.apiError, detail, component: component)
    }

    /// Log a ERROR message
    static func error(_ message: String, _ detail: String? = nil, component: String = #file) {
        shared.error(message, component: component)
    }
    
    static func error(_ error: Error, _ detail: String? = nil, component: String = #file) {
        shared.optional(error, detail, component: component)
    }
}
