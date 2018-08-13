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
            return "\".*\""
        case .int:
            return "^[0-9]+$"
        case .bool:
            return "(false|true)"
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

enum JSONType {
    case string(String)
    case int(Int)
    case bool(Bool)
    case object([String:JSONType])
}

struct Formatter {
    private var tokens: [String]
    
    init(tokens: [String]) {
        self.tokens = tokens
    }
    
    // 형식이 올바르지 않다면 nil을 반환
    func isValidTokens() -> [JSONType]?{
        var validTokens: [JSONType] = []
        
        for token in tokens {
            if JSONRegex.string.isValid(target: token) {
                validTokens.append(JSONType.string(token))
            }else if JSONRegex.int.isValid(target: token) {
                validTokens.append(JSONType.int(Int(token)!))
            }else if JSONRegex.bool.isValid(target: token) {
                validTokens.append(JSONType.bool(Bool(token)!))
            }else if JSONRegex.object.isValid(target: token) {
                let object = generateObject(from: token)
                validTokens.append(JSONType.object(object))
            }else{
                return nil
            }
        }
        
        return validTokens
    }
    
    // *Object format이라는게 증명됨
    private func generateObject(from target: String) -> [String:JSONType] {
        var values: [String:JSONType] = [:]
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
                    values[key] = generateJSONType(value)
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
                    values[key] = generateJSONType(value)
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
    
    private func generateJSONType(_ value: String) -> JSONType {
        if let value = Int(value) {
            return JSONType.int(value)
        }
        
        if let value = Bool(value) {
            return JSONType.bool(value)
        }
        
        // *Object format 이라는게 증명됨
        return JSONType.string(value)
    }
}
