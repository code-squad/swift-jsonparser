//
//  Extensions.swift
//  JSONParser
//
//  Created by rhino Q on 2018. 3. 29..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true":
            return true
        case "False", "false":
            return false
        default:
            return nil
        }
    }
}

extension Character {
    var asciiValue: Int {
        get {
            let s = String(self).unicodeScalars
            return Int(s[s.startIndex].value)
        }
    }
}

protocol TokenBasicValueable {
    func getToken() -> Token
}

extension Double : TokenBasicValueable {
    func getToken() -> Token {
        return .number(value: self)
    }
}

extension String : TokenBasicValueable {
    func getToken() -> Token {
        return .string(value:self)
    }
}

extension Bool : TokenBasicValueable {
    func getToken() -> Token {
        return .bool(value:self)
    }
}
