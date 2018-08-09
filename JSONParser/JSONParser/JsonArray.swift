//
//  Json.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 4..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct JsonArray:JsonProtocol {
    private var array:Array<TypeProtocol>
    
    init() {
        self.array = []
    }
    
    public mutating func addArray(element:String) {
        // 객체 {} 의 경우에는 String 으로 저장합니다.
        if element.isObject() {
            self.array.append(element)
        }else if element.isBool(){
            self.array.append(Bool(element)!)
        }else if element.isNumber() {
            print("element : \(element)")
            self.array.append(Int(element)!)
        }else {
            self.array.append(element)
        }
    }
    
    public func count() -> (Int,Int,Int,Int) {
        var string = 0
        var int = 0
        var bool = 0
        var object = 0
        
        for element in self.array {
            if let string = element as? String , string.isObject() {
                object = object + 1
            }else if element is Bool {
                bool = bool + 1
            }else if element is Int {
                int = int + 1
            }else {
                string = string + 1
            }
        }
        return (string, int, bool, object)
    }
}
