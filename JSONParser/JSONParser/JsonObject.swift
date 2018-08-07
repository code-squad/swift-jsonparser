//
//  JsonObject.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 6..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct JsonObject:JsonProtocol {
    private var object:[String:String]
    
    init() {
        self.object = [:]
    }
    
    public mutating func addObject(key:String, value:String) {
        self.object.updateValue(value, forKey: key)
    }
    
    public func count() -> (Int,Int,Int,Int) {
        var string = 0
        var int = 0
        var bool = 0
        var object = 0
        
        for ( _ , value) in self.object {
            let allowCharacterSet = CharacterSet.init(charactersIn: "1234567890")
            if value.hasPrefix("{") {
                object = object + 1
            }else if value.contains("true") || value.contains("false"){
                bool = bool + 1
            }else if value.trimmingCharacters(in: allowCharacterSet).isEmpty {
                int = int + 1
            }else {
                string = string + 1
            }
        }
        
        return (string, int, bool, object)
    }
    
    
}
