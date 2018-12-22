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
        return "총 \(parserData.1)개의 배열 데이터 중에 "
    }
    var parserResultPrint: String {
        var resultData = ""
        
        if self.parserData.0.0.count != 0 { resultData += "문자열 \(parserData.0.0.count)개," }
        if self.parserData.0.1.count != 0 { resultData += "숫자 \(parserData.0.1.count)개," }
        if self.parserData.0.2.count != 0 { resultData += "부울 \(parserData.0.2.count)개," }
        
        resultData.removeLast()
        return resultData
    }
    
    let parserData: (([String],[String],[String]),Int)
    
    init(_ parserData: (([String],[String],[String]),Int)) {
        self.parserData = parserData
    }
}
