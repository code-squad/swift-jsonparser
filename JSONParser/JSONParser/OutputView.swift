//
//  OutputView.swift
//  JSONParser
//
//  Created by yangpc on 2017. 10. 30..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    static func printJSON(_ jsonData: JSONData) {
        var resultJSONDataString = ""
        var resultJSONCountString = ""
        var indent = 1
        var typeCountDictionary = [String:Int]()
        if jsonData.array.count == 1 {
            // 오브젝트 데이터 일 때
            guard let object = jsonData.array[0] as? JSONObject else { return }
            typeCountDictionary = calculateNumberOfType(jsonData.array)
            resultJSONCountString = makeJSONCountString(typeCountDictionary,
                                                        objectCount: object.dictionary.count)
            resultJSONDataString += makeJSONDataString(jsonData.array, indent: indent)
        } else {
            // 배열 데이터 일 때
            typeCountDictionary = calculateNumberOfType(jsonData.array)
            resultJSONCountString = makeJSONCountString(typeCountDictionary, arrayCount: jsonData.array.count)
            if isOneMoreIndentFronObject(jsonData.array) {
                indent += 1
            }
            resultJSONDataString += makeJSONDataString(jsonData.array, indent: indent)
        }
        print(resultJSONCountString)
        print(resultJSONDataString)
    }
    
    // 데이터 내부에 배열, 객체, 스트링, 인트, 부울 타입이 몇 개인지 계산 하는 함수
    private static func calculateNumberOfType(_ values: [Value]) -> Dictionary<String, Int> {
        var arrayCount = 0
        var jsonObjectCount = 0
        var stringCount = 0
        var intCount = 0
        var boolCount = 0
        for value in values {
            switch value {
            case is JSONObject: jsonObjectCount += 1
            case is String: stringCount += 1
            case is Int: intCount += 1
            case is Bool: boolCount += 1
            case is [Value]: arrayCount += 1
            default: break
            }
        }
        return ["객체": jsonObjectCount,
                "문자열": stringCount,
                "숫자": intCount,
                "부울": boolCount,
                "배열": arrayCount]
    }
    
    // 오브젝트 앞에 인덴트가 두 개 인지 한 개 인지 판별
    private static func isOneMoreIndentFronObject(_ values: [Value]) -> Bool {
        var moreThanOneIndent = false
        // 오브젝트 다음 배열, 배열 다음 배열일 때 : 오브젝트의 인덴트가 2
        var preExistObject = false
        var preExistArray = false
        
        for value in values {
            if moreThanOneIndent { break }
            switch value {
            case is JSONObject:
                if !preExistObject {
                    preExistObject = true
                }
            case is [Value]:
                if !preExistArray {
                    preExistArray = true
                }
                if preExistArray || preExistObject {
                    moreThanOneIndent = true
                }
            default:
                preExistObject = false
                preExistArray = false
            }
        }
        return moreThanOneIndent
    }
    
    // 데이터 내부에 타입 개수 분석한 결과를 바탕으로 스트링을 생성
    private static func makeJSONCountString(_ typeCountDictionary: Dictionary<String,Int>,
                                            objectCount: Int = 0,
                                            arrayCount: Int = 0) -> String {
        var resultForAnalyzingJSONData = ""
        if objectCount > 0 {
            resultForAnalyzingJSONData += "총 \(objectCount) 개의 객체 데이터 중에"
        } else {
            resultForAnalyzingJSONData += "총 \(arrayCount) 개의 배열 데이터 중에"
        }
        for (type,count) in typeCountDictionary where count != 0 {
            resultForAnalyzingJSONData += " \(type) \(count)개,"
        }
        resultForAnalyzingJSONData.removeLast()
        resultForAnalyzingJSONData += "가 포함되어 있습니다."
        return resultForAnalyzingJSONData
    }
    
    // JSON 데이터를 스트링으로 생성
    private static func makeJSONDataString(_ values: [Value], indent: Int) -> String {
        var result = ""
        var preExistPrimitiveTypeValue = false
        if values.count > 1 {
            result += "["
        }
        for value in values {
            switch value {
            case is JSONObject:
                guard let valueObject = value as? JSONObject else { continue }
                let dictionary = valueObject.dictionary
                result += "{"
                for (key, value) in dictionary {
                    if indent == 1 {
                        result += "\n\t\"\(key)\" : \(convertValueToString(value)),"
                    } else {
                        result += "\n\t\t\"\(key)\" : \(convertValueToString(value)),"
                    }
                }
                result.removeLast()
                if indent == 1 {
                    result += "\n}, "
                }
                else {
                    result += "\n\t}, "
                }
                preExistPrimitiveTypeValue = false
            case is [Value]:
                guard let valueArray = value as? [Value] else { break }
                if preExistPrimitiveTypeValue {
                    result += "\(valueArray), "
                    preExistPrimitiveTypeValue = false
                }
                else {
                    result += "\n\t\(valueArray), "
                }
            default:
                preExistPrimitiveTypeValue = true
                result += "\(convertValueToString(value)), "
            }
        }
        result.removeSubrange(
            result.index(result.endIndex, offsetBy: -2)...result.index(before: result.endIndex))
        if indent == 2 {
            result += "\n"
        }
        if values.count > 1 {
            result += "]"
        }
        return result
    }
    
    private static func convertValueToString(_ value: Value) -> String {
        var resultString = ""
        switch value {
        case is String: resultString += "\"\(value)\""
        default: resultString += "\(value)"
        }
        return resultString
    }
    
}
