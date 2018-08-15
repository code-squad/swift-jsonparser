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
        
        if json is JSONArray { // 배열의 형태라면 바로 값들로부터 JSONValue를 생성 시도
            do {
                json.values = try generateJSONValue(from: tokens)
            }catch let err {
                throw err
            }
        }else if json is JSONObject { // 단일 객체의 형태라면 먼저 객체 안에서 키-값 쌍을 딕셔너리 형태로 묶어 추출
            let object = tokens[0] // 단일 객체이니 0 번째 인덱스
            let parsedObject = Tokenizer.parseObject(object) // 객체에서 키-값 쌍을 분리하여 하나의 딕셔너리로 추출
            let keys = parsedObject.keys.map {String($0)} // [키]를 따로 추출
            let values = parsedObject.values.map {String($0)} // [값]을 따로 추출
            do {
                var object:[String:JSONValueType] = [:]
                let validJSONTypeValues = try generateJSONValue(from: values) // 따로 추출한 [값]으로부터 JSONValue 추출, 이중 중첩 탐지.
                for (index, value) in keys.enumerated() { // 이중 중첩이 존재하지 않는다면 따로 추출한 키와 생성한 JSONValue 배열로 딕셔너리 생성
                    object[value] = validJSONTypeValues[index]
                }
                json.values = [JSONValueType.object(object)] // 해당 딕셔너리를 다시 JSONValue로 wrapping하여 최종 JSONType의 values로 할당
            }catch let err {
                throw err
            }
        }
        
        return json
    }
    
    // 인자로 넘어오는 토큰들로부터 JSONValueType 배열 타입을 반환
    private static func generateJSONValue(from tokens: [String]) throws -> [JSONValueType] {
        var values: [JSONValueType] = []
        for token in tokens {
            guard let format = JSONRegex.format(of: token) else { // 형식이 맞지 않는 포멧이 존재한다면 throw 에러
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
                    let object = try generateObject(from: token) // 토큰의 형식이 객체 형식이라면 JSONValueType.object로 wrapping / 이중 중첩이라면 throw 에러
                    values.append(JSONValueType.object(object))
                }catch let err {
                    throw err
                }
            case .array:
                do {
                    let array = try generateArray(from: token) // 토큰의 형식이 객체 형식이라면 JSONValueType.array로 wrapping / 이중 중첩이라면 throw 에러
                    values.append(JSONValueType.array(array))
                }catch let err {
                    throw err
                }
            }
        }
        return values
    }
    
    // 토큰의 형식이 배열 형식이라면 JSONValue.array로 wrapping하기 위해 가공
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
                        try values.append(wrapUp(with: value)) // 값이 어떤 형식의 값인지 판단후 해당 값을 JSONValue.해당값형식으로 wrapping
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
                try values.append(wrapUp(with: value))
            }catch let err {
                throw err
            }
        }
        return values
    }
    
    // 토큰의 형식이 객체 형식이라면 JSONValue.object로 wrapping하기 위해 가공
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
                        values[key] = try wrapUp(with: value)
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
                        values[key] = try wrapUp(with: value)
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
    
    /*
    - 이 함수를 호출하는 경우
     1. JSONArray의 형식으로 배열안에 배열이나 객체가 있을경우 해당 형식에 대해서만 호출
     2. JSONObject로 단일 객체 형식으로 객체안의 키-값 쌍 중 [값]에 배열이나 객체가 있을 경우 해당 형식에 대해서만 호출
     즉 이중 중첩을 판단하는 메소드
     */
    private static func wrapUp(with token: String) throws -> JSONValueType {
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
