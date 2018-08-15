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
        let singleArrayPattern = "\\[\\s*(\(valuesPattern))(,\\s*(\(valuesPattern)))*\\s*\\]"
        let singleObjectPattern = "\\{\\s*\".*\"\\s*:\\s*(\(valuesPattern))\\s*(,\\s*\".*\"\\s*:\\s*(\(valuesPattern))\\s*)*\\}"
        switch self {
        case .string:
            return "^\"(?!.*\"\\s*:\\s*).*\"$"
        case .int:
            return "^[0-9]+$"
        case .bool:
            return "(^false|^true)"
        case .object:
            let nestedObject = "^\\{\\s*\".*\"\\s*:\\s*(\(singleObjectPattern)|\(singleArrayPattern)|\(valuesPattern))\\s*(,\\s*\".*\"\\s*:\\s*(\(singleObjectPattern)|\(singleArrayPattern)|\(valuesPattern))\\s*)*\\}$"
            return nestedObject
        case .array:
            let nestedArrayPattern = "^\\[\\s*(\(valuesPattern)|(\(singleObjectPattern)|\(singleArrayPattern)))\\s*(,\\s*(\(valuesPattern)|(\(singleObjectPattern)|\(singleArrayPattern))))*\\s*\\]$"
            return nestedArrayPattern
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
    static func generateJSON(from tokens: [String]) throws -> JSONType {
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
                let object = generateObject(from: token)
                values.append(JSONValueType.object(object))
            case .array:
                print("Array")
            }
        }
        
        return generateJSONType(values)
    }
    
    private static func generateJSONType(_ values: [JSONValueType]) -> JSONType {
        // 분류된 값들로 Array인지 단일 Object인지 판단
        var objects = 0
        var others = 0
        values.forEach {
            switch $0 {
            case .object(_):
                objects += 1
            default:
                others += 1
            }
        }
        // 객체가 단 하나만 존재한다면 이는 단일 객체로 판단
        if objects == 1 && others == 0 {
            return JSONObject(values.first!)
        }
        
        return JSONArray(values)
    }
    
    private static func generateArray(from target: String) -> [JSONValueType] {
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
                    values.append(generateJSONValueType(value))
                    value = ""
                }
            default:
                value += String(character)
            }
        }
        if value != "" {
            values.append(generateJSONValueType(value))
        }
        return values
    }
    
    // *Object format이라는게 증명됨
    private static func generateObject(from target: String) -> [String:JSONValueType] {
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
                    values[key] = generateJSONValueType(value)
                    value = ""                  // 초기화
                    key = ""                    // 초기화
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
                    values[key] = generateJSONValueType(value)
                    value = ""                  // 값 초기화
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
    
    private static func generateJSONValueType(_ value: String) -> JSONValueType {
        if let value = Int(value) {
            return JSONValueType.int(value)
        }
        
        if value == "false" || value == "true" {
            return JSONValueType.bool(Bool(value)!)
        }
        
        // *Object format 이라는게 증명됨
        return JSONValueType.string(value)
    }
}
