//
//  JsonSyntaxRull.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 18..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

// Json 문법 구조체
struct JsonGrammerRule {
    static let ofString = "\\s*?\"[^\"]+\"\\s*?"
    static let ofInt = "\\s*?\\d+\\s*?"
    static let ofBool = "\\s*?(true|false)\\s*?"
    static let ofDictionary = "\\s*?\(ofString)\\s*?:\\s*?(\(ofInt)|\\s*?\(ofString)|\\s*?\(ofBool))\\s*?"
    static let ofObject = "\\s*?[\\{]\\s*?(\(ofDictionary)\\s*?[,]?\\s*?)+\\s*?[\\}]\\s*?"
    static let ofArray = "\\[\\s*?((\(ofInt)|\\s*?\(ofString)|\\s*?\(ofBool)|\\s*?\(ofObject))[,]?)+\\s*?\\]\\s*?"
    static let ofValue = "\(ofString)|\(ofInt)|\(ofBool)"
    
    static let ofNestedDictionary = "\\s*?\(ofString)\\s*?:\\s*?(\(ofString)|\(ofInt)|\(ofBool)|\(ofObject)|\(ofArray))"
    static let ofNestedObject = "\\{(\(ofNestedDictionary)\\s*?[,]?\\s*?)+\\s*?[\\}]\\s*?"
    static let ofNestedArray = "\\s*\\[((\(ofString)|\(ofInt)|\(ofBool)|\(ofObject)|\(ofArray))[,]?)+\\s*\\]"
}
