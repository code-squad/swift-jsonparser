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
        return "총 \(parserData.count)개의 배열 데이터 중에 "
    }
    var parserResultPrint: String {
        var resultData = ""
        
        
        
        resultData.removeLast()
        return resultData
    }
    
    let parserData: [Any]
    
    init(_ parserData: [Any]) {
        self.parserData = parserData
    }
}
