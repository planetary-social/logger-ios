//
//  LogProtocol.swift
//  
//
//  Created by Martin Dutra on 26/4/22.
//

import Foundation

public protocol LogProtocol {

    /// URLs in the device's filesystem that contain what was logged in this and previous sessions
    var fileUrls: [URL] { get }

    /// Log a ERROR message
    /// - Returns: True if an error could be unwrapped
    ///
    /// Convenience function that unwraps the error (if exists) and logs its description
    @discardableResult
    func optional(_ error: Error?, _ detail: String?, component: String) -> Bool

    /// Log a INFO message
    func info(_ string: String, component: String)

    /// Log a DEBUG message
    func debug(_ string: String, component: String)

    /// Log a ERROR message
    func error(_ string: String, component: String)

    /// Log a ERROR message
    ///
    /// Convencience function that categorize common errors that the app can handle
    func unexpected(_ reason: Reason, _ detail: String?, component: String)

    /// Log a FATAL message
    ///
    /// Convencience function that categorize common errors that the app cannot handle
    func fatal(_ reason: Reason, _ detail: String?, component: String)
}
