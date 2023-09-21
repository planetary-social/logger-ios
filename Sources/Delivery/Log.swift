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
    public func optional(_ error: Error?, _ detail: String? = nil, sourceFile: String = #file) -> Bool {
        service.optional(error, detail, sourceFile: sourceFile)
    }

    public func info(_ string: String, sourceFile: String = #file) {
        service.info(string, sourceFile: sourceFile)
    }

    public func debug(_ string: String, sourceFile: String = #file) {
        service.debug(string, sourceFile: sourceFile)
    }

    public func error(_ string: String, sourceFile: String = #file) {
        service.unexpected(string, nil, sourceFile: sourceFile)
    }

    public func unexpected(_ reason: Reason, _ detail: String?, sourceFile: String = #file) {
        service.unexpected(reason.rawValue, detail, sourceFile: sourceFile)
    }

    public func fatal(_ reason: Reason, _ detail: String?, sourceFile: String = #file) {
        service.fatal(reason.rawValue, detail, sourceFile: sourceFile)
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
    static func optional(_ error: Error?, _ detail: String? = nil, sourceFile: String = #file) -> Bool {
        shared.optional(error, detail, sourceFile: sourceFile)
    }

    /// Log a INFO message
    static func info(_ string: String, sourceFile: String = #file) {
        shared.info(string, sourceFile: sourceFile)
    }

    /// Log a DEBUG message
    static func debug(_ string: String, sourceFile: String = #file) {
        shared.debug(string, sourceFile: sourceFile)
    }

    /// Log a ERROR message
    ///
    /// Convencience function that categorize common errors that the app can handle
    static func unexpected(_ reason: Reason, _ detail: String?, sourceFile: String = #file) {
        shared.unexpected(reason, detail, sourceFile: sourceFile)
    }

    /// Log a FATAL message
    ///
    /// Convencience function that categorize common errors that the app cannot handle
    static func fatal(_ reason: Reason, _ detail: String?, sourceFile: String = #file) {
        shared.fatal(reason, detail, sourceFile: sourceFile)
    }

    /// Log a ERROR message
    ///
    /// Convenience function that unwraps an error and a response from a network call
    static func optional(_ error: Error?, from response: URLResponse?, sourceFile: String = #file) {
        guard let error = error else { return }
        guard let response = response else { return }
        let path = response.url?.path ?? "unknown path"
        let detail = "\(path) \(error)"
        shared.unexpected(.apiError, detail, sourceFile: sourceFile)
    }

    /// Log a ERROR message
    static func error(_ message: String, _ detail: String? = nil, sourceFile: String = #file) {
        shared.error(message, sourceFile: sourceFile)
    }
    
    static func error(_ error: Error, _ detail: String? = nil, sourceFile: String = #file) {
        shared.optional(error, detail, sourceFile: sourceFile)
    }
}
