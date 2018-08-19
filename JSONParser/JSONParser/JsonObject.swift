//
//  JsonObject.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 6..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct JsonObject:Jsonable {
    private var object:[String:JsonType]
    
    init() {
        self.object = [:]
    }
    
    init(jsonObject : [String:JsonType]) {
        self.object = jsonObject
    }
    
    public func countData() -> (Int,Int,Int,Int,Int) {
        var string = 0
        var int = 0
        var bool = 0
        var object = 0
        var array = 0
        
        for ( _ , value) in self.object {
            switch value {
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
    
    public func generateData() -> String {
        return self.makeObject(intent: 1, elements: self.object)
    }
}
