//
//  JsonCommon.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 29..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

// 출력 데이터 추상화 (카운팅 및 Json타입 형태)
protocol JSONDataCommon {
    func readyforPrinting () -> String
    func getCountedType () -> JSONData
}

// 타입별 값을 가져오는 부분 추상화
protocol JSONType {
    func getJSONtype () -> JSONType
    func makeValueFromObject () -> String
    func makeValueFromArray () -> String
}

// 타입별 extension
extension Dictionary: JSONDataCommon, JSONType {
    func makeValueFromArray() -> String {
        return JSONPrintingMaker.makeObjectTypeForPrinting(self as! Dictionary<String, JSONType>, innerIndent: 2, outerIndent: 2) + ElementOfString.comma.rawValue
    }
    
    func makeValueFromObject() -> String {
        return JSONPrintingMaker.makeObjectTypeForPrinting(self as! Dictionary<String, JSONType>, innerIndent: 1, outerIndent: 0)
    }
    
    func getJSONtype() -> JSONType {
        return self as! Dictionary<String, JSONType>
    }
    
    func getCountedType() -> JSONData {
        return CountingJSONData.getCountedObjectType(self as! Dictionary<String, JSONType>)
    }
    
    func readyforPrinting() -> String{
        return JSONPrintingMaker.makeObjectTypeForPrinting(self as! Dictionary<String, JSONType>, innerIndent: 1, outerIndent: 0)
    }
}

extension Array: JSONDataCommon, JSONType {
    func makeValueFromArray() -> String {
        return JSONPrintingMaker.insertIndentation(indent: 1) + String(describing: self as! [JSONType]) + ElementOfString.comma.rawValue
    }
    
    func makeValueFromObject() -> String {
        return String(describing: self as! [JSONType])
    }
    
    func getJSONtype() -> JSONType {
        return self as! [String]
    }
    
    func getCountedType() -> JSONData {
        return CountingJSONData.getCountedArrayType(self as!  [JSONType])
    }
    
    func readyforPrinting() -> String{
        return JSONPrintingMaker.makeArrayTypeForPrinting(self as! [JSONType] )
    }
}

extension Int: JSONType {
    func makeValueFromArray() -> String {
        return String(describing: self) + ElementOfString.comma.rawValue
    }
    
    func makeValueFromObject() -> String {
        return String(describing: self)
    }
    
    func getJSONtype() -> JSONType {
        return Int(self)
    }
}

extension String: JSONType {
    func makeValueFromArray() -> String {
        return JSONPrintingMaker.insertIndentation(indent: 1) + ElementOfString.doubleQuotationMarks.rawValue + String(describing: self) + ElementOfString.doubleQuotationMarks.rawValue + ElementOfString.comma.rawValue
    }
    
    func makeValueFromObject() -> String {
        return ElementOfString.doubleQuotationMarks.rawValue + String(describing: self) + ElementOfString.doubleQuotationMarks.rawValue
    }
    
    func getJSONtype() -> JSONType {
        return String(self)
    }
}

extension Bool: JSONType {
    func makeValueFromArray() -> String {
        return String(describing: self) + ElementOfString.comma.rawValue
    }
    
    func makeValueFromObject() -> String {
        return String(describing: self)
    }
    
    func getJSONtype() -> JSONType {
        return Bool(self)
    }
}
