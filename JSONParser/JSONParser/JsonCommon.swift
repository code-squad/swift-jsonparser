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

extension Dictionary: JsonDataCommon {
    func getCountedType() -> JsonData {
        return CountingJsonData.getCountedObjectType(self as! Dictionary<String, Any>)
    }
    
    func readyforPrinting() -> String{
        var result = ""
        result +=  JsonPrintingMaker.makeObjectTypeForPrinting(self as! Dictionary<String, Any>)
        return result
    }
}

extension Array: JsonDataCommon {
    func getCountedType() -> JsonData {
        return CountingJsonData.getCountedArrayType(self as!  [String])
    }
    
    func readyforPrinting() -> String{
        var result = ""
        result +=  JsonPrintingMaker.makeArrayTypeForPrinting(self as! [String])
        return result
    }
}
