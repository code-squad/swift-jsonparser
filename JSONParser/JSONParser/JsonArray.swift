//
//  Json.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 4..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct JsonArray:JsonProtocol {
    private var array:Array<Any>
    
    init() {
        self.array = []
    }
    
    public mutating func addArray(element:String) {
        self.array.append(element)
    }
    
    public func count() -> (Int,Int,Int,Int) {
        var string = 0
        var int = 0
        var bool = 0
        var object = 0
        
        for element in self.array {
            let allowCharacterSet = CharacterSet.init(charactersIn: "1234567890")
            if (element as AnyObject).contains("true") || (element as AnyObject).contains("false"){
                bool = bool + 1
            }else if (element as AnyObject).trimmingCharacters(in: allowCharacterSet).isEmpty {
                int = int + 1
            }else if (element as AnyObject).hasPrefix("{") {
                object = object + 1
            }else {
                string = string + 1
            }
        }
        
        return (string, int, bool, object)
    }
}
