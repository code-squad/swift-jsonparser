//
//   FirstObjectProtocol.swift
//  JSONParser
//
//  Created by Eunjin Kim on 2017. 12. 5..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

protocol FirstObject {
    init()
    mutating func compareToParsingTable() -> Int
    mutating func searchNextRegexIndex(row: Int, col: Int) -> Int
}
