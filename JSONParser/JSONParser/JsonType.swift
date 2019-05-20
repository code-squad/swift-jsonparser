//
//  JsonType.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/29/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum JsonType {
    case int(Int)
    case string(String)
    case bool(Bool)
    case object([String: JsonType])
    case array([JsonType])
    
    var name: JsonTypeName {
        switch self {
        case .bool(_): return JsonTypeName.bool
        case .int(_): return JsonTypeName.int
        case .object(_): return JsonTypeName.object
        case .string(_): return JsonTypeName.string
        case .array(_): return JsonTypeName.array
        }
    }
    
    var string: String {
        switch self {
        case let .array(array): return arrayToString(array)
        case let .bool(bool): return boolToString(bool)
        case let .int(int): return String(int)
        case let .string(string): return String(string)
        case .object(_): return objectToString(self)
        }
    }
    
    private func objectToString (_ object: JsonType) -> String {
        let curlyBracketOpen = DevideCharacter.curlyBracketOpen
        let curlyBracketClose = DevideCharacter.curlyBracketClose
        
        var result: String = String(curlyBracketOpen.rawValue)
        var valueObject = ""
        
        if case let JsonType.object(object) = object {
            for (key, value) in object {
                valueObject = value.string
                result += "\n\t\(key) : \(valueObject),"
            }
        }
        
        result.removeLast()
        result += "\n"
        result += String(curlyBracketClose.rawValue)
        return result
    }
    
    private func arrayToString (_ array: [JsonType]) -> String {
        let squareBracketOpen = DevideCharacter.squareBracketOpen
        let squareBracketClose = DevideCharacter.squareBracketClose
        let comma = DevideCharacter.comma
        
        var result: String = ""
        
        if array.count>1 {
            result += String(squareBracketOpen.rawValue)
        }
        
        for element in array {
            result += element.string
            result += String(comma.rawValue)
        }
        result.removeLast()
        
        if array.count>1 {
            result += String(squareBracketClose.rawValue)
        }
        
        return result
    }
    
    private func boolToString (_ bool: Bool) -> String {
        if bool {
            return "true"
        } else {
            return "false"
        }
    }
}

enum JsonTypeName: String {
    case int = "숫자"
    case string = "문자열"
    case bool = "부울"
    case object = "객체"
    case array = "배열"
    case total = "총"
    case nothing = ""
}
