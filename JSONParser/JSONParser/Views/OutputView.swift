//
//  OutputView.swift
//  JSONParser
//
//  Created by 이진영 on 28/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    static func printParseResult(result: JsonType) {
        if result is JsonArray {
            printArray(result)
        }
    }
    
    private static func printArray(_ array: JsonType) {
        guard let result = array as? JsonArray else {
            return
        }
        
        var description = "\(result.array.count)개의 데이터 중에 "
        
        for (type, count) in result.typeCounter {
            description.append("\(type) \(count)개 ")
        }
        
        print(description)
    }
}
