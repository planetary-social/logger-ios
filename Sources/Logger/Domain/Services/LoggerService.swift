//
//  LoggerService.swift
//  
//
//  Created by Martin Dutra on 22/11/21.
//

import Foundation

protocol LoggerService {

    var fileUrls: [URL] { get }

    func optional(_ error: Error?, _ detail: String?) -> Bool
    func info(_ string: String)
    func debug(_ string: String)
    func unexpected(_ reason: String, _ detail: String?)
    func fatal(_ reason: String, _ detail: String?)

}
