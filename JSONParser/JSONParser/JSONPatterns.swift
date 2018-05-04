//
//  JSONPatterns.swift
//  JSONParser
//
//  Created by rhino Q on 2018. 5. 1..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct JSONPatterns {
    static let numberPattern = "\\d+\\.?\\d*"
    static let boolPattern = "false|true"
    static let stringPattern = "\"[^\\\"]+?\""
    
    static let objectPattern = "\\s*\\{(?:\\s*\(stringPattern)\\s*:\\s*(\(stringPattern)|\(boolPattern)|\(numberPattern)))(?:\\s*,\\s*(?:\(stringPattern)\\s*:\\s*(\(stringPattern)|\(boolPattern)|\(numberPattern))))*\\s*\\}"
    
    static let nestedObjectPattern = "\\s*\\{(?:\\s*\(stringPattern)\\s*:\\s*(\(stringPattern)|\(boolPattern)|\(numberPattern)|\(arrayPattern)))(?:\\s*,\\s*(?:\(stringPattern)\\s*:\\s*(\(stringPattern)|\(boolPattern)|\(numberPattern)|\(arrayPattern))))*\\s*\\}"
    
    static let arrayPattern = "\\s*\\[\\s*(?:\\s*(\(objectPattern)|\(stringPattern)|\(numberPattern)|\(boolPattern)))(?:\\s*,\\s*(?:\(objectPattern)|\(stringPattern)|\(numberPattern)|\(boolPattern)))*\\s*\\]"
    
    static let nestedArrayPattern = "\\s*\\[(?:\\s*(\(objectPattern)|\(arrayPattern)|\(stringPattern)|\(numberPattern)|\(boolPattern)))(?:\\s*,\\s*(?:\(objectPattern)|\(arrayPattern)|\(stringPattern)|\(numberPattern)|\(boolPattern)))*\\s*\\s*\\]"

}
