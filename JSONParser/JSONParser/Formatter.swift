//
//  FormatValidator.swift
//  JSONParser
//
//  Created by 이동건 on 13/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

enum JSONRegex {
    case string
    case int
    case bool
    case object
    case array
    
    var pattern: String {
        let valuesPattern = "false|true|[0-9]+|\".*\""
        switch self {
        case .string:
            return "^\"(?!.*\"\\s*:\\s*).*\"$"
        case .int:
            return "^[0-9]+$"
        case .bool:
            return "(^false|^true)"
        case .object:
            return "^\\{\\s*\".*\"\\s*:\\s*(\(valuesPattern))\\s*(,\\s*\".*\"\\s*:\\s*(\(valuesPattern))\\s*)*\\}$"
        case .array:
            return "^\\[\\s*(\(valuesPattern))(,\\s*(\(valuesPattern)))*\\s*\\]$"
        }
    }
    
    private func isValid(target: String) -> Bool {
        if let regex = try? NSRegularExpression(pattern: self.pattern, options: .caseInsensitive) {
            let value = target as NSString
            return !regex.matches(in: target, options: [], range: NSRange(location: 0, length: value.length)).isEmpty
        }
        return false
    }
    
    static func format(of target: String) -> JSONRegex? {
        switch target {
        case let value where JSONRegex.string.isValid(target: value):
            return .string
        case let value where JSONRegex.int.isValid(target: value):
            return .int
        case let value where JSONRegex.bool.isValid(target: value):
            return .bool
        case let value where JSONRegex.object.isValid(target: value):
            return .object
        case let value where JSONRegex.array.isValid(target: value):
            return .array
        default: return nil
        }
    }
}

struct Formatter {
    
    // 형식이 올바르지 않다면 nil을 반환
    static func generateJSON(from tokens: [String], _ type: JSONType) throws -> JSONType {
        var json = type
        
        if json is JSONArray {
            do {
                json.values = try generateJSONValue(from: tokens)
            }catch let err {
                throw err
            }
        }else if json is JSONObject {
            let object = tokens[0]
            let parsedObject = Tokenizer.parseObject(object)
            let keys = parsedObject.keys.map {String($0)}
            let values = parsedObject.values.map {String($0)}
            do {
                var object:[String:JSONValueType] = [:]
                let validJSONTypeValues = try generateJSONValue(from: values)
                for (index, value) in keys.enumerated() {
                    object[value] = validJSONTypeValues[index]
                }
                json.values = [JSONValueType.object(object)]
            }catch let err {
                throw err
            }
        }
        
        return json
    }
    
    private static func generateJSONValue(from tokens: [String]) throws -> [JSONValueType] {
        var values: [JSONValueType] = []
        for token in tokens {
            guard let format = JSONRegex.format(of: token) else {
                throw JSONParserError.invalidFormat
            }
            switch format {
            case .string:
                values.append(JSONValueType.string(token))
            case .int:
                values.append(JSONValueType.int(Int(token)!))
            case .bool:
                values.append(JSONValueType.bool(Bool(token)!))
            case .object:
                do {
                    let object = try generateObject(from: token)
                    values.append(JSONValueType.object(object))
                }catch let err {
                    throw err
                }
            case .array:
                do {
                    let array = try generateArray(from: token)
                    values.append(JSONValueType.array(array))
                }catch let err {
                    throw err
                }
            }
        }
        return values
    }
    
    private static func generateArray(from target: String) throws -> [JSONValueType] {
        var rawArray = target
        rawArray.removeFirst()
        rawArray.removeLast()
        
        var values: [JSONValueType] = []
        var value = ""
        var isString = false
        
        for character in rawArray {
            switch character {
            case Components.doubleQuote.value:
                isString = !isString
                value += String(character)
            case Components.space.value :
                if isString {
                    value += String(character)
                }
            case Components.comma.value:
                if isString {
                    value += String(character)
                }else {
                    do {
                        try values.append(generateJSONValueType(from: value))
                        value = ""
                    }catch let err {
                        throw err
                    }
                }
            default:
                value += String(character)
            }
        }
        if value != "" {
            do {
                try values.append(generateJSONValueType(from: value))
            }catch let err {
                throw err
            }
        }
        return values
    }
    
    private static func generateObject(from target: String) throws -> [String:JSONValueType] {
        var values: [String:JSONValueType] = [:]
        var value = ""
        var isString = false
        var isKey = false
        var key = ""
        
        for character in target {
            switch character {
            case Components.objectOpener.value:
                if isString {
                    value += String(character)  // 문자열의 일부면 추가
                }else{
                    isKey = !isKey              // 객체 시작을 의미
                }
            case Components.objectCloser.value:
                if isString {
                    value += String(character)  // 문자열의 일부면 추가
                }else {
                    do {
                        values[key] = try generateJSONValueType(from: value)
                        value = ""              // 초기화
                        key = ""
                    }catch let err {
                        throw err
                    }
                }
            case Components.space.value:
                if isString {
                    value += String(character)  // 문자열의 일부면 추가
                }
            case Components.doubleQuote.value:
                isString = !isString            // 문자열의 시작이나 끝을 의미
                value += String(character)      // 값에 추가
            case Components.comma.value:
                if isString {
                    value += String(character)  // 문자열의 일부면 추가
                }else {
                    do {
                        values[key] = try generateJSONValueType(from: value)
                        value = ""
                    } catch let err {
                        throw err
                    }
                }
            case Components.colon.value:
                if isString {
                    value += String(character)  // 문자열의 일부면 추가
                }else{
                    isKey = !isKey              // 키가 끝난 것을 의미
                    key = value                 // 키에 값을 할당해줌
                    value = ""                  // 값 초기화
                }
            default:
                value += String(character)      // 문자열에 추가
            }
        }
        
        return values
    }
    
    private static func generateJSONValueType(from token: String) throws -> JSONValueType {
        guard let format = JSONRegex.format(of: token) else {
            throw JSONParserError.invalidFormat
        }
        
        switch format {
        case .string:
            return JSONValueType.string(token)
        case .int:
            return JSONValueType.int(Int(token)!)
        case .bool:
            return JSONValueType.bool(Bool(token)!)
        case .object:
            throw JSONParserError.invalidFormat
        case .array:
            throw JSONParserError.invalidFormat
        }
    }
}
