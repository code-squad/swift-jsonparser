//
//  TokenSplitUnit.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 4. 20..
//  Copyright © 2018년 JK. All rights reserved.
//

enum TokenSplitUnit {
    case startBracket
    case endBrackert
    case comma
    case startBrace
    case endBrace
    case colon
    
    var char: Character {
        switch self {
        case .startBracket:
            return "["
        case .endBrackert:
            return "]"
        case .comma:
            return ","
        case .startBrace:
            return "{"
        case .endBrace:
            return "}"
        case .colon:
            return ":"
        }
    }
    
    var string: String {
        switch self {
        case .startBracket:
            return "["
        case .endBrackert:
            return "]"
        case .comma:
            return ","
        case .startBrace:
            return "{"
        case .endBrace:
            return "}"
        case .colon:
            return ":"
        }
    }
}

enum Capsule: String {
    case Bracket = "[]"
    case Brace = "{}"
}

enum RegexPatten: String {
    case NumberPatten = "[0-9]"
    case StringPatten = "\"[a-z]|[A-Z]\""
    case BooleanPaten = "false|true|FALSE|TRUE"
}

enum JSONType {
    case Number(Int)
    case String(String)
    case Boolean(Bool)
    case Array([JSONType])
    case Object([String : JSONType])
    case ObjectArray([[String: JSONType]])
    
    var number: Int? {
        
        guard case .Number(let number) = self else {
            return nil
        }
        
        return number
    }
    
    var string: String? {
        guard case .String(let string) = self else {
            return nil
        }
        return string
    }
    
    var boolean: Bool? {
        guard case .Boolean(let boolean) = self else {
            return nil
        }
        return boolean
    }
    
    var array: [JSONType]? {
        guard case .Array(let array) = self else {
            return nil
        }
        return array
    }
    
    var object: [String: JSONType]? {
        guard case .Object(let object) = self else {
            return nil
        }
        return object
    }
    
    var objectArray: [[String: JSONType]]? {
        guard case .ObjectArray(let objectArray) = self else {
            return nil
        }
        return objectArray
    }
}
