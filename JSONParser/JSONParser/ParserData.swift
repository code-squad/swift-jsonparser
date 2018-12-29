//
//  ParserData.swift
//  JSONParser
//
//  Created by Elena on 22/12/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct ParserData: JSONResult {
    
    var resultDataPrint: String {

        return "총 \(parserData.dataInt.count + parserData.dataString.count + parserData.dataBool.count) 개의 객체 데이터 중에 "
    }
    
    var parserResultPrint: String {
        
        var resultData = ""
        
        if self.parserData.dataString.count != 0 { resultData += "문자열 \(parserData.dataString.count)개," }
        if self.parserData.dataInt.count != 0 { resultData += "숫자 \(parserData.dataInt.count)개," }
        if self.parserData.dataBool.count != 0 { resultData += "부울 \(parserData.dataBool.count)개," }
        
        resultData.removeLast()
        return resultData
    }
    
    let parserData: JSONData
    
    init(_ parserData: JSONData) {
        self.parserData = parserData
    }
}


struct ParserObjectData: JSONResult {
    
    var resultDataPrint: String {
        return "총 \(parserData.objectCount)개의 배열 데이터 중에"
    }
    
    var parserResultPrint: String {
        return "객체 \(parserData.objectCount)개가 포함되어 있습니다."
    }
    
    let parserData: ObjectData
    
    init(_ parserData: ObjectData) {
        self.parserData = parserData
    }
}

