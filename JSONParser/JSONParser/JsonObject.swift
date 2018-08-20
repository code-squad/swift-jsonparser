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
    
    public func makeObject(intent : Int, elements : [String:JsonType]) -> String {
        var message = "{"
        message += "\n"
        for (key,value) in elements {
            for _ in 0..<intent {
                message += "\t"
            }
            let typeValue = value.description(intent: intent)
            message += "\(key) : "
            message += "\(typeValue),"
            message += "\n"
        }
        message.removeLast(2) // for remove last "," (뒤에서 두번째 index를 삭제)
        message += "\n"
        for _ in 0..<intent-1 {
            message += "\t"
        }
        message += "}"
        return message
    }
    
}
