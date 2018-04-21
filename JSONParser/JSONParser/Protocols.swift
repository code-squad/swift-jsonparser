//
//  Protocols.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 18..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

protocol JSONPrintable {
    func total() -> Int
    func totalDataType() -> TotalDataType
    func countValueDescription() -> String
    func countObjectDescription() -> String
}
