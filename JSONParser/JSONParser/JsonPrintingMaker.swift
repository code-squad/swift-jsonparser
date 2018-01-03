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
   
    static func makeObjectTypeForPrinting(_ jsonObjectType: Dictionary<String,JSONType>) -> String {
        var result: String = ""
        result += "{" + makeNewLine()
        result += getValuesFromObject(jsonObjectType)
        result.removeLast(2)
        result += makeNewLine() + "}"
        return result
    }
    
    static func makeArrayTypeForPrinting(_ jsonArrayType: [String]) -> String {
        var result: String = ""
        result += "[" + makeNewLine()
        result += getValueFromArray(jsonArrayType)
        result.removeLast(2)
        result += makeNewLine() + "]"
        return result
    }
    
    private static func getValuesFromObject(_ jsonObjectType: Dictionary<String,JSONType>) -> String {
        var result: String = ""
        _ = jsonObjectType.forEach {
            let value = $0.value.makeValueFromObject()
            result += insertIndentation() + "\"\($0.key)\" : \(value)" + "," + makeNewLine()
        }
        return result
    }
    
    private static func getValueFromArray(_ jsonArrayType: Array<JSONType>) -> String {
        var result: String = ""
        _ = jsonArrayType.forEach {
           result += $0.makeValueFromArray()
        }
        return result
    }
    
     static func insertIndentation () -> String {
        return "\t"
    }
    
     static func makeNewLine () -> String {
        return "\n"
    }
}
