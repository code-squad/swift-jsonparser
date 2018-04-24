//
//  Protocols.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 18..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

protocol JSONPrintable {
    func totalDataCountDescription() -> String
    func totalDataTypeDescription() -> String
    func countDataDescription() -> String
}

protocol Token {
    func numberOfToken() -> Int
    func getToken(index: Int) -> String
}

protocol JSONData {
    init(jsonData: JSONDataType)
}
