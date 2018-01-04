//
//  JsonCommon.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 29..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

// 출력 데이터 추상화 (카운팅 및 Json타입 형태)
protocol JsonDataCommon {
    func readyforPrinting () -> String
    func getCountedType () -> JsonData
}

protocol JSONType {
    func getJsontype () -> JSONType
    func makeValueFromObject () -> String
    func makeValueFromArray () -> String
}

extension Dictionary: JsonDataCommon, JSONType {
    func makeValueFromArray() -> String {
        return JsonPrintingMaker.makeObjectTypeForPrinting(self as! Dictionary<String, JSONType>, innerIndent: 2, outerIndent: 2) + "," + JsonPrintingMaker.makeNewLine()
    }
    
    func makeValueFromObject() -> String {
        return JsonPrintingMaker.makeObjectTypeForPrinting(self as! Dictionary<String, JSONType>, innerIndent: 1, outerIndent: 0)
    }
    
    func getJsontype() -> JSONType {
        return self as! Dictionary<String, JSONType>
    }
    
    func getCountedType() -> JsonData {
        return CountingJsonData.getCountedObjectType(self as! Dictionary<String, JSONType>)
    }
    
    func readyforPrinting() -> String{
        return JsonPrintingMaker.makeObjectTypeForPrinting(self as! Dictionary<String, JSONType>, innerIndent: 1, outerIndent: 0)
    }
}

extension Array: JsonDataCommon, JSONType {
    func makeValueFromArray() -> String {
        return JsonPrintingMaker.insertIndentation(indent: 1) + String(describing: self as! [JSONType]) + ","
    }
    
    func makeValueFromObject() -> String {
        return String(describing: self as! [JSONType])
    }
    
    func getJsontype() -> JSONType {
        return self as! [String]
    }
    
    func getCountedType() -> JsonData {
        return CountingJsonData.getCountedArrayType(self as!  [JSONType])
    }
    
    func readyforPrinting() -> String{
        return JsonPrintingMaker.makeArrayTypeForPrinting(self as! [JSONType] )
    }
}

extension Int: JSONType {
    func makeValueFromArray() -> String {
        return String(describing: self) + ","
    }
    
    func makeValueFromObject() -> String {
        return String(describing: self)
    }
    
    func getJsontype() -> JSONType {
        return Int(self)
    }
}

extension String: JSONType {
    func makeValueFromArray() -> String {
        return JsonPrintingMaker.insertIndentation(indent: 1) + "\"" + String(describing: self) + "\"" + ","
    }
    
    func makeValueFromObject() -> String {
        return "\"" + String(describing: self) + "\""
    }
    
    func getJsontype() -> JSONType {
        return String(self)
    }
}

extension Bool: JSONType {
    func makeValueFromArray() -> String {
        return String(describing: self) + ","
    }
    
    func makeValueFromObject() -> String {
        return String(describing: self)
    }
    
    func getJsontype() -> JSONType {
        return Bool(self)
    }
}
