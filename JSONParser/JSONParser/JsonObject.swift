//
//  JsonObject.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 6..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct JsonObject:JsonProtocol {
    private var object:[String:TypeProtocol]
    
    init() {
        self.object = [:]
    }
    
    public mutating func addObject(key:String, value:String) {
        if value.isBool(){
            self.object.updateValue(Bool(value)!, forKey: key)
        }else if value.isNumber(){
            self.object.updateValue(Int(value)!, forKey: key)
        }else {
            self.object.updateValue(value, forKey: key)
        }
    }
    
    public func count() -> (Int,Int,Int,Int) {
        var string = 0
        var int = 0
        var bool = 0
        var object = 0
        
        for ( _ , value) in self.object {
            if let string = value as? String , string.hasPrefix("{") {
                object = object + 1
            }else if value is Bool {
                bool = bool + 1
            }else if value is Int {
                int = int + 1
            }else {
                string = string + 1
            }
        }   
        return (string, int, bool, object)
    }
}
