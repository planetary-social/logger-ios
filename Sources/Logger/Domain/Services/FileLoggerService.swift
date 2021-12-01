//
//  FileLoggerService.swift
//  
//
//  Created by Martin Dutra on 1/12/21.
//

import Foundation

protocol FileLoggerService {

    var fileUrls: [URL] { get }

    func debug(_ string: String)
    
    func info(_ string: String)

    func error(_ string: String)

}
