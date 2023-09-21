//
//  LoggerService.swift
//  
//
//  Created by Martin Dutra on 10/2/22.
//

import Foundation

protocol LoggerService {

    var fileUrls: [URL] { get }

    func debug(_ string: String, component: String)

    func info(_ string: String, component: String)

    func optional(_ error: Error?, _ detail: String?, component: String) -> Bool

    func unexpected(_ reason: String, _ detail: String?, component: String)

    func fatal(_ reason: String, _ detail: String?, component: String)
}
