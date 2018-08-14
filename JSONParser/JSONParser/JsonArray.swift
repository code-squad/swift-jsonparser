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
    
    public mutating func addArray(element:String) {
        // 객체 {} 의 경우에는 String 으로 저장합니다.
        if element.isObject() {
            self.array.append(JsonType.object(element))
        }else if element.isBool(){
            self.array.append(JsonType.bool(Bool(element)!))
        }else if element.isNumber() {
            self.array.append(JsonType.int(Int(element)!))
        }else {
            self.array.append(JsonType.string(element))
        }
    }
    
    public func count() -> (Int,Int,Int,Int) {
        var string = 0
        var int = 0
        var bool = 0
        var object = 0
        
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
            }
        }
        return (string, int, bool, object)
    }
}
