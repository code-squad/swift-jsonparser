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
    
    var pattern: String {
        switch self {
        case .string:
            return "^\".*\"$"
        case .int:
            return "^[0-9]+$"
        case .bool:
            return "(^false|^true)"
        case .object:
            return "^\\{\\s*\".*\"\\s*:\\s*(true|false|[0-9]+|\".*\")\\s*(,\\s*\".*\"\\s*:\\s*(true|false|[0-9]+|\".*\")\\s*)*\\}$"
        }
    }
    
    func isValid(target: String) -> Bool {
        if let regex = try? NSRegularExpression(pattern: self.pattern, options: .caseInsensitive) {
            let value = target as NSString
            return !regex.matches(in: target, options: [], range: NSRange(location: 0, length: value.length)).isEmpty
        }
        return false
    }
}

struct Formatter {
    private var tokens: [String]
    
    init(tokens: [String]) {
        self.tokens = tokens
    }
    
    // 형식이 올바르지 않다면 nil을 반환
    func isValidTokens() -> JSONType?{
        var validTokens: [JSONValueType] = []
        
        for token in tokens {
            
            if JSONRegex.object.isValid(target: token) {
                let object = generateObject(from: token)
                validTokens.append(JSONValueType.object(object))
            }else if JSONRegex.int.isValid(target: token) {
                validTokens.append(JSONValueType.int(Int(token)!))
            }else if JSONRegex.bool.isValid(target: token) {
                validTokens.append(JSONValueType.bool(Bool(token)!))
            }else if JSONRegex.string.isValid(target: token) {
                validTokens.append(JSONValueType.string(token))
            }else{
                return nil
            }
        }
        
        return generateJSON(validTokens)
    }
    
    private func generateJSON(_ values: [JSONValueType]) -> JSONType {
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
        
        if objects == 1 && others == 0 {
            return JSONObject(values.first!)
        }
        
        return JSONArray(values)
    }
    
    // *Object format이라는게 증명됨
    private func generateObject(from target: String) -> [String:JSONValueType] {
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
    
    private func generateJSONValueType(_ value: String) -> JSONValueType {
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
