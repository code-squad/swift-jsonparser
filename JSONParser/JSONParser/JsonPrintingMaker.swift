//
//  JsonPrintingMaker.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 28..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JsonPrintingMaker {
    static func makeJsonTypeforPrinting(jsonType: Any) -> String{
        if let jsonObjectType = jsonType as? Dictionary<String,Any> {
            return  makeObjectTypeForPrinting(jsonObjectType)
        } else {
            return  makeArrayTypeForPrinting(jsonType as! Array<String>)
        }
    }
    
    private static func makeObjectTypeForPrinting(_ jsonObjectType: Dictionary<String,Any>) -> String {
        var result: String = ""
        result += "{" + makeNewLine()
        result += getValuesFromObject(jsonObjectType)
        result.removeLast(2)
        result += makeNewLine() + "}"
        return result
    }
    
    private static func getValuesFromObject(_ jsonObjectType: Dictionary<String,Any>) -> String {
        var result: String = ""
        _ = jsonObjectType.forEach {
            var value = ""
            if $0.value is String {
                value = "\"" + String(describing: $0.value) + "\""
            } else if let arrayOfJsonType = $0.value as? Array<String> {
                value = makeArrayTypeForPrinting(arrayOfJsonType)
            } else {
                value = String(describing: $0.value)
            }
            result += insertIndentation() + "\"\($0.key)\" : \(value)" + "," + makeNewLine()
        }
        return result
    }
    
    private static func makeArrayTypeForPrinting(_ jsonArrayType: [String]) -> String {
        var result: String = ""
        result += "[" + makeNewLine()
        result += getValueFromArray(jsonArrayType)
        result.removeLast(2)
        result += makeNewLine() + "]"
        return result
    }
    
    private static func getValueFromArray(_ jsonArrayType: Array<Any>) -> String {
        var result: String = ""
        _ = jsonArrayType.forEach {
            if $0 is String {
                result += insertIndentation() + String(describing: $0) + "," + makeNewLine()
            } else if let JsonObjectType = $0 as? Dictionary<String,Any> {
                result += makeObjectTypeForPrinting(JsonObjectType) + "," + makeNewLine()
            } else if let arrayTypeInArray = $0 as? Array<String> {
                result += makeArrayTypeForPrinting(arrayTypeInArray)
            } else {
                result += String(describing: $0)
            }
        }
        return result
    }
    
    private static func insertIndentation () -> String {
        return "\t"
    }
    
    private static func makeNewLine () -> String {
        return "\n"
    }
}
