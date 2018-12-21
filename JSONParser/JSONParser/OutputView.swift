//
//  OutputView.swift
//  JSONParser
//
//  Created by Elena on 19/12/2018.
//  Copyright © 2018 elena. All rights reserved.
//

import Foundation

struct OutputView {
    
    static func resultPrint(_ parseData: [String:Int]?) {
        guard let validParseData = parseData else {
            return
        }
        let allData = (validParseData["String"] ?? 0) + (validParseData["Bool"] ?? 0) + (validParseData["Int"] ?? 0)
        print("총 \(allData)개의 데이터 중에 \(parseDataPrint(validParseData))포함되어 있습니다.")
    }
    
    private static func parseDataPrint(_ data: [String:Int]) -> String {
        var resultData = ""
        if data["String"] != 0 { resultData += "문자열 \(data["String"] ?? 0)개 " }
        if data["Bool"] != 0 { resultData += "부울 \(data["Bool"] ?? 0)개 " }
        if data["Int"] != 0 { resultData += "숫자 \(data["Int"] ?? 0)개 " }
        return resultData
        
    }
    
}
