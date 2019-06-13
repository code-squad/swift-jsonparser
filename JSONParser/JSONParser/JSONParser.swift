//
//  JSONParser.swift
//  JSONParser
//
//  Created by JieunKim on 05/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    
    static func parseArray(tokens: [String]) -> [JSONDataType] {
      return tokens.compactMap {
            parseValue(data:$0)
        }
    }
    
    private static func parseValue(data: String) -> JSONDataType? {
        if let string = parseString(data: data) {
            return string
        } else if let number = parseNumber(data: data) {
            return number
        } else if let bool = parseBool(data: data) {
            return bool
        } else {
            return nil
        }
    }
    
    private static func parseString(data: String) -> String? {
        guard data.first == "\"" && data.last == "\"" else {
            return nil
        }
        var data = data
        data.removeFirst()
        data.removeLast()
        return data
    }
    
    private static func parseNumber(data: String) -> Number? {
        return Number(data)
    }
    
    private static func parseBool(data: String) -> Bool? {
        switch data {
        case "true":
            return true
        case "false":
            return false
        default:
            return nil
        }
    }
    
//    private static func parseObject(data: String) -> [String: JSONDataType]? {
//        
//    }
}



