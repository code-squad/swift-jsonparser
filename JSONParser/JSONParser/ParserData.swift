//
//  ParserData.swift
//  JSONParser
//
//  Created by Elena on 22/12/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
// if self.parserData.0.0.first == "String" { resultData += "dddddd" }
// testcode: 작성할떄 배열의 첫번째에 데이터를 저장해서  이걸활용해서 데이터가 있는지 없는지 확인하면 좋을것 같다.

struct ParserData: JSONResult {
    
    var resultDataPrint: String {
        return "총 \(parserData.1)개의 배열 데이터 중에 "
    }
    var parserResultPrint: String {
        var resultData = ""
        
        if self.parserData.0.0.count != 0 { resultData += "문자열 \((parserData.0.0.count)-1)개," }
        if self.parserData.0.1.count != 0 { resultData += "숫자 \((parserData.0.1.count)-1)개," }
        if self.parserData.0.2.count != 0 { resultData += "부울 \((parserData.0.2.count)-1)개," }
        
        resultData.removeLast()
        return resultData
    }
    
    let parserData: (([String],[String],[String]),Int)
    
    init(_ parserData: (([String],[String],[String]),Int)) {
        self.parserData = parserData
    }
}
