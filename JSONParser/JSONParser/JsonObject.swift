//
//  JsonObject.swift
//  JSONParser
//
//  Created by 이진영 on 14/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonObject: Countable {
    let object: [String : JsonType]
    
    var typeDescription: String {
        return TypeName.object.rawValue
    }
    
    var typeCount: [String : Int] {
        var typeCounter: [String : Int] = [:]
        
        for (_, value) in object {
            let typeName = String(describing: type(of: value))
            
            typeCounter[typeName] = (typeCounter[typeName] ?? 0) + 1
        }
        
        return typeCounter
    }
    
    init(object: [String : JsonType]) throws {
        if object.count == 0 {
            throw ParseError.noData
        }
        
        self.object = object
    }
}
