//
//  JsonPrintingMaker.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 28..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JsonPrintingMaker {
    
    static func makeJsonTypeforPrinting(jsonType: JsonDataCommon) -> String {
        return jsonType.readyforPrinting()
    }
    
    static func makeObjectTypeForPrinting(_ jsonObjectType: Dictionary<String,JSONType>, innerIndent: Int, outerIndent: Int) -> String {
        var result: String = ElementOfString.emptyString.rawValue
        result += ElementOfString.leftBrace.rawValue + makeNewLine()
        result += getValuesFromObject(jsonObjectType, indent: innerIndent)
        result.removeLast(2)
        result += makeNewLine() + insertIndentation(indent: outerIndent) + ElementOfString.rightBrace.rawValue
        return result
    }
    
    static func makeArrayTypeForPrinting(_ jsonArrayType: [JSONType]) -> String {
        var result: String = ElementOfString.emptyString.rawValue
        result += ElementOfString.leftSquareBracket.rawValue
        result += getValueFromArray(jsonArrayType)
        result.removeLast(1)
        result += makeNewLine() + ElementOfString.rightSquareBracket.rawValue
        return result
    }
    
    private static func getValueFromArray(_ jsonArrayType: Array<JSONType>) -> String {
        var result: String = ElementOfString.emptyString.rawValue
        jsonArrayType.forEach {
            result += $0.makeValueFromArray()
        }
        return result
    }
    
    private static func getValuesFromObject(_ jsonObjectType: Dictionary<String,JSONType> , indent: Int) -> String {
        var result: String = ElementOfString.emptyString.rawValue
        jsonObjectType.forEach {
            let value = $0.value.makeValueFromObject()
            result += insertIndentation(indent: indent) + makeKeyAndValueOfDictionary(key: $0.key, value: value)  + ElementOfString.comma.rawValue + makeNewLine()
        }
        return result
    }
    
    private static func makeKeyAndValueOfDictionary (key inputKey: String, value inputValue: String) -> String {
        return "\(inputKey)\" : \(inputValue)"
    }
    
    static func insertIndentation ( indent: Int) -> String {
        return String(repeating: "\t", count: indent)
    }
    
    static func makeNewLine () -> String {
        return "\n"
    }
}
