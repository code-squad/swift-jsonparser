//
//  JSONPainter.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONPainter {
    private let jsonType: JSONType
    private(set) var jsonPainting: String = ""
    private var depth: Int = 0

    init(jsonType: JSONType) {
        self.jsonType = jsonType
        paintJSON()
    }

    func getJSONResultAll() -> String {
        return getCountResult() + "\n" + jsonPainting
    }

    private mutating func paintJSON() {
        if let jsonObject = jsonType as? JSONObject {
            jsonPainting = paintObjectType(jsonObject: jsonObject)
        } else if let jsonArray = jsonType as? JSONArray {
            jsonPainting = paintArrayType(jsonArray: jsonArray, endFlag: true)
        }
    }

    private mutating func paintObjectType(jsonObject: JSONObject) -> String {
        var result: String = ""
        result += "{\n"
        result += paintInsideOfObject(jsonObject: jsonObject)
        result.removeLast(2)
        result += "\n" + String(repeating: "\t", count: depth) + "}"
        return result
    }

    private mutating func paintInsideOfObject(jsonObject: JSONObject) -> String {
        var result: String = ""
        for (key, value) in jsonObject {
            var valueString: String = ""
            if value is String {
                valueString = "\"" + String(describing: value) + "\""
            } else if let jsonArray = value as? JSONArray {
                valueString = paintArrayType(jsonArray: jsonArray, endFlag: false)
            } else {
                valueString = String(describing: value)
            }
            result += String(repeating: "\t", count: depth+1) + "\"\(key)\" : \(valueString)" + ",\n"
        }
        return result
    }

    private mutating func paintArrayType(jsonArray: JSONArray, endFlag: Bool) -> String {
        var result: String = ""
        result += "["
        result += paintInsideOfArray(jsonArray: jsonArray)
        result.removeLast(2)
        if depth > 0 && endFlag == true {
            result += "\n"
        }
        result += "]"
        return result
    }

    private mutating func paintInsideOfArray(jsonArray: JSONArray) -> String {
        var result: String = ""
        for element in jsonArray {
            if element is String {
                result += "\"" + String(describing: element) + "\", "
            } else if let jsonObject = element as? JSONObject {
                result += paintObjectType(jsonObject: jsonObject) + ",\n"
            } else if let jsonInsideArray = element as? JSONArray {
                depth += 1
                result += "\n" + String(repeating: "\t", count: depth)
                result += paintArrayType(jsonArray: jsonInsideArray, endFlag: false) + ", "
            } else {
                result += String(describing: element) + ", "
            }
        }
        return result
    }

}

typealias JSONCounter = JSONPainter
private extension JSONCounter {

    func getCountResult() -> String {
        var result : String = "총 \(jsonType.totalCounter)개의 \(jsonType.container) 데이터 중에"
        result += getObjectCounter()
        result += getStringCounter()
        result += getIntCounter()
        result += getBoolCounter()
        result += getArrayCounter()
        result.removeLast()
        result += "가 포함되어 있습니다."
        return result
    }

    func getStringCounter() -> String {
        if jsonType.stringCounter > 0 {
            return " 문자열 \(jsonType.stringCounter)개,"
        }
        return ""
    }

    func getIntCounter() -> String {
        if jsonType.intCounter > 0 {
            return " 숫자 \(jsonType.intCounter)개,"
        }
        return ""
    }

    func getBoolCounter() -> String {
        if jsonType.boolCounter > 0 {
            return " 부울 \(jsonType.boolCounter)개,"
        }
        return ""
    }

    func getObjectCounter() -> String {
        if jsonType.objectCounter > 0 {
            return " 객체 \(jsonType.objectCounter)개,"
        }
        return ""
    }

    func getArrayCounter() -> String {
        if jsonType.arrayCounter > 0 {
            return " 배열 \(jsonType.arrayCounter)개,"
        }
        return ""
    }

}
