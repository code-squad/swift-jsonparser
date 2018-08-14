//
//  JsonObject.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 6..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct JsonObject:JsonProtocol {
    private var object:[String:JsonType]
    
    init() {
        self.object = [:]
    }
    
    public mutating func addObject(key:String, value:String) {
        if value.isObject(){
            self.object.updateValue(JsonType.object(value), forKey: key)
        }else if value.isBool(){
            self.object.updateValue(JsonType.bool(Bool(value)!), forKey: key)
        }else if value.isNumber(){
            self.object.updateValue(JsonType.int(Int(value)!), forKey: key)
        }else {
            self.object.updateValue(JsonType.string(value), forKey: key)
        }
    }
    
    public func count() -> (Int,Int,Int,Int,Int) {
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
    
}
