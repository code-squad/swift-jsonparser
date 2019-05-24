//
//  JSONSymbols.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum JSONSymbols: String {
    case openBracket  = "["
    case closedBracket  = "]"
    case openBrace = "{"
    case closedBrace = "}"
    case comma = ","
    case blank = " "
    case doubleQuotation = "\""
    case colon = ":"
    
    func equals(_ token: String) -> Bool {
        return self.rawValue == token
    }
    
    func equals(_ token: Character) -> Bool {
        let convertedToken = String(token)
        return equals(convertedToken)
    }
    
    func notEquals(_ token: String) -> Bool {
        return !equals(token)
    }
    
    func notEquals(_ token: Character) -> Bool {
        return !equals(token)
    }
}
