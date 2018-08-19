//
//  Json.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 4..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct JsonArray:Jsonable {
    private var array:Array<JsonType>
    
    init() {
        self.array = []
    }
    
    init(jsonArray : [JsonType]) {
        self.array = jsonArray
    }
    
    public func countData() -> (Int,Int,Int,Int,Int) {
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
    
    public func generateData() -> String {
        /*
         배열 안에 string, int, bool 중에 하나라도 있는 경우 : 시작 intent 0
         배열 안에 object, array 만 있는 경우 : 시작 intent 1
         */
        var intent = 1
        let (string,int,bool,_,_) = self.countData()
        if string > 1 || int > 1 || bool > 1 {
            intent = 0
        }
        return self.makeArray(intent: intent, elements: self.array)
    }
}
