//
//  OutputView.swift
//  JSONParser
//
//  Created by yangpc on 2017. 10. 30..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    static func printAnalyzeResult(_ jsonData: JSONData) {
        var resultForAnalyzingJSONData = ""
        var typeCountDictionary = [String:Int]()
        if jsonData.array.count == 1 {
            guard let object = jsonData.array[0] as? JSONObject else { return }
            resultForAnalyzingJSONData += "총 \(object.dictionary.count) 개의 객체 데이터 중에"
            typeCountDictionary = calculateNumberOfType(Array(object.dictionary.values))
        } else {
            resultForAnalyzingJSONData += "총 \(jsonData.array.count) 개의 배열 데이터 중에"
            typeCountDictionary = calculateNumberOfType(jsonData.array)
        }
        for (type,count) in typeCountDictionary where count != 0 {
            resultForAnalyzingJSONData += " \(type) \(count)개,"
        }
        resultForAnalyzingJSONData.removeLast()
        resultForAnalyzingJSONData += "가 포함되어 있습니다."
        print(resultForAnalyzingJSONData)
    }
    
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
    
    static func printJSON(_ jsonData: JSONData) {
        var resultJSONDataString = ""
        if jsonData.array.count == 1 {
            resultJSONDataString += makeJSONDataString(jsonData.array, indent: 1)
        } else {
            resultJSONDataString = "["
            resultJSONDataString += makeJSONDataString(jsonData.array, indent: 2)
            resultJSONDataString += "\n]"
        }
        print(resultJSONDataString)
    }
    
    private static func makeJSONDataString(_ values: [Value], indent: Int) -> String {
        var result = ""
        for value in values {
            switch value {
            case is JSONObject:
                guard let valueObject = value as? JSONObject else { continue }
                let dictionary = valueObject.dictionary
                result += "{"
                for (key, value) in dictionary {
                    if indent == 1 {
                        result += "\n\t\"\(key)\" : \(value),"
                    } else {
                        result += "\n\t\t\"\(key)\" : \(value),"
                    }
                }
                result.removeLast()
                if indent == 1 { result += "\n}  "}
                else { result += "\n\t}, " }
            case is [Value]:
                guard let valueArray = value as? [Value] else { break }
                result += "\n\t\(valueArray), "
            default:
                result += "\n\t\(value), "
            }
        }
        result.remove(at: result.index(result.endIndex, offsetBy: -2))
        return result
    }
}



