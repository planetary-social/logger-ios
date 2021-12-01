//
//  LoggerService.swift
//  
//
//  Created by Martin Dutra on 22/11/21.
//

import Foundation
import os.log

protocol LoggerService {

    var fileUrls: [URL] { get }

    func debug(_ string: String)

    func info(_ string: String)

    func optional(_ error: Error?, _ detail: String?) -> Bool

    func unexpected(_ reason: String, _ detail: String?)

    func fatal(_ reason: String, _ detail: String?)

}
