//
//  JsonArray.swift
//  JSONParser
//
//  Created by 이진영 on 24/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonArray: JsonType {
    let array: [JsonType]
    
    var typeDescription: String {
        var typeCounter: [String : Int] = [:]
        var description = "\(array.count)개의 데이터 중에 "
        
        for element in array {
            switch element {
            case is Int:
                typeCounter[TypeName.number.rawValue] = (typeCounter[TypeName.number.rawValue] ?? 0) + 1
            case is String:
                typeCounter[TypeName.string.rawValue] = (typeCounter[TypeName.string.rawValue] ?? 0) + 1
            case is Bool:
                typeCounter[TypeName.bool.rawValue] = (typeCounter[TypeName.bool.rawValue] ?? 0) + 1
            default:
                break
            }
        }
        
        for (type, count) in typeCounter {
            description.append("\(type) \(count)개 ")
        }
        
        return description
    }
    
    init(array: [JsonType]) throws {
        if array.count == 0 {
            throw ParseError.noData
        }
        
        self.array = array
    }
}
