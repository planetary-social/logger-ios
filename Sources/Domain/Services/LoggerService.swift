//
//  LoggerService.swift
//  
//
//  Created by Martin Dutra on 10/2/22.
//

import Foundation

protocol LoggerService {

    var fileUrls: [URL] { get }

    func debug(_ string: String, sourceFile: String)

    func info(_ string: String, sourceFile: String)

    func optional(_ error: Error?, _ detail: String?, sourceFile: String) -> Bool

    func unexpected(_ reason: String, _ detail: String?, sourceFile: String)

    func fatal(_ reason: String, _ detail: String?, sourceFile: String)
}
