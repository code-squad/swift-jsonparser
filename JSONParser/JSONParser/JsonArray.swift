//
//  Json.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 4..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct JsonArray:JsonProtocol {
    private var array:Array<JsonType>
    
    init() {
        self.array = []
    }
    
    init(jsonArray : [JsonType]) {
        self.array = jsonArray
    }
    
    public func count() -> (Int,Int,Int,Int,Int) {
        var string = 0
        var int = 0
        var bool = 0
        var object = 0
        var array = 0
        
        for element in self.array {
            switch element {
            case .string:
                string = string + 1
            case .int:
                int = int + 1
            case .bool:
                bool = bool + 1
            case .object:
                object = object + 1
            case .array:
                array = array + 1
            }
        }
        return (string, int, bool, object, array)
    }
}
