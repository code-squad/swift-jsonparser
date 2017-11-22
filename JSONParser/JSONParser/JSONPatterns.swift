//
//  JSONPatterns.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 22..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONPatterns {
    // basic pattern
    static private let stringPattern: String  = "[\\s]*\"[^\"]+\"[\\s]*"
    static private let intPattern: String = "[\\s]*\\d+[\\s]*"
    static private let boolPattern: String = "[\\s]*(true|false)[\\s]*"
    static private let dictionaryPattern: String = "\(stringPattern):(\(stringPattern)|\(intPattern)|\(boolPattern))"
    static let objectPattern: String = "[\\s]*\\{(\(dictionaryPattern){1}[,]{1})*\(dictionaryPattern)\\}[\\s]*"
    static let arrayPattern: String = "[\\s]*\\[((\(stringPattern)|\(intPattern)|\(boolPattern)|\(objectPattern)){1}[,]{1})*(\(stringPattern)|\(intPattern)|\(boolPattern)|\(objectPattern))\\][\\s]*"
    // nested pattern
    static let nestedDictionaryPattern: String = "\(stringPattern):(\(stringPattern)|\(intPattern)|\(boolPattern)|\(objectPattern)|\(arrayPattern))"
    static let nestedObjectPattern: String = "[\\s]*?\\{(\(nestedDictionaryPattern){1}[,]{1})*\(nestedDictionaryPattern){1}\\}[\\s]*?"
    static let nestedArrayPattern: String = "[\\s]*?\\[((\(stringPattern)|\(intPattern)|\(boolPattern)|\(nestedObjectPattern)|\(arrayPattern)){1}[,]{1})*(\(stringPattern)|\(intPattern)|\(boolPattern)|\(nestedObjectPattern)|\(arrayPattern)){1}\\][\\s]*?"
    static let insideArrayPattern: String  = "[\\s]*?\\[((\(stringPattern)|\(intPattern)|\(boolPattern)|\(nestedObjectPattern)){1}[,]{1})*(\(arrayPattern)[,]?)((\(stringPattern)|\(intPattern)|\(boolPattern)|\(nestedObjectPattern)){1}[,]?)*[\\s]*?\\][\\s]*?"
}
