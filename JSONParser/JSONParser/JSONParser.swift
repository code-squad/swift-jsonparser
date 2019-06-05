//
//  JSONParser.swift
//  JSONParser
//
//  Created by JieunKim on 05/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    static func parseValue (data: String) throws -> JSONDataType {
        
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
        return nil
    }
    
    private static func parseNumber(data: String) -> Number? {
        return nil
    }
    
    private static func parseBool(data: String) -> Bool? {
        return nil
    }
}



