//
//  JSONParser.swift
//  JSONParser
//
//  Created by JieunKim on 05/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    
    static func parseArray(data: [String]) throws -> [JSONDataType] {
        var result = [JSONDataType]()
        for string in data {
        result.append(try parseValue(data: string))
        }
        return result
    }
    
    static func parseValue(data: String) throws -> JSONDataType {
        if let string = parseString(data: data) {
            return string
        } else if let number = parseNumber(data: data) {
            return number
        } else if let bool = parseBool(data: data) {
            return bool
        } else {
            throw JSONError.wrongValue
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
}



