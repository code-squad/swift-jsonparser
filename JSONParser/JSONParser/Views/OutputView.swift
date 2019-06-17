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
        } else if result is JsonObject {
            printObject(result)
        }
    }
    
    private static func printArray(_ array: JsonType) {
        guard let result = array as? JsonArray else {
            return
        }
        
        var description = "\(result.array.count)개의 배열 데이터 중에 "
        
        for (type, count) in result.typeCounter {
            description.append("\(type) \(count)개 ")
        }
        
        print(description)
    }
    
    private static func printObject(_ object: JsonType) {
        guard let result = object as? JsonObject else {
            return
        }
        
        var description = "\(result.object.count)개의 객체 데이터 중에 "
        
        for (type, count) in result.typeCounter {
            description.append("\(type) \(count)개 ")
        }
        
        print(description)
    }
}
