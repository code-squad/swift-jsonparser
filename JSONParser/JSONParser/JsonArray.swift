//
//  JsonArray.swift
//  JSONParser
//
//  Created by 이진영 on 24/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonArray: JsonType, Countable {
    let array: [JsonType]
    
    var typeDescription: String {
        return TypeName.array.rawValue
    }
    
    var typeCount: [String : Int] {
        var typeCounter: [String : Int] = [:]
        
        for element in array {
            let typeName = String(describing: type(of: element))
            
            typeCounter[typeName] = (typeCounter[typeName] ?? 0) + 1
        }
        
        return typeCounter
    }
    
    init(array: [JsonType]) throws {
        if array.count == 0 {
            throw ParseError.noData
        }
        
        self.array = array
    }
}
