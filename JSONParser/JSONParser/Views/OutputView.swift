//
//  OutputView.swift
//  JSONParser
//
//  Created by 이진영 on 28/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    static func printParseResult(result: Countable) {
        var resultCount = 0
        var description = ""
        
        for (type, count) in result.typeCount {
            description.append("\(type) \(count)개 ")
            resultCount = resultCount + count
        }
        
        description = "\(resultCount)개의 \(String(describing: type(of: result))) 데이터 중에 \(description)"
        
        print(description)
    }
    
    static func printPretty(result: Countable) {
        print(result.serialize(indent: 0))
    }
}
