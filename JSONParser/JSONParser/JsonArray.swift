//
//  Json.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 4..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct JsonArray:JsonProtocol {
    private var string:Array<String>
    private var int:Array<Int>
    private var bool:Array<Bool>
    private var object:Array<Any>
    
    init() {
        self.string = []
        self.int = []
        self.bool = []
        self.object = []
    }
    
    public mutating func addString(element:String) {
        self.string.append(element)
    }
    
    public mutating func addInt(element:String) {
        if let convertInt = Int(element) {
            self.int.append(convertInt)
        }
    }
    
    public mutating func addBool(element:String) {
        if element == "true" {
            self.bool.append(true)
        }else {
            self.bool.append(false)
        }
    }
    
    public mutating func addObject(element:String) {
        self.object.append(element)
    }
    
    public func count() -> (Int,Int,Int,Int) {
        let string = self.string.count
        let int = self.int.count
        let bool = self.bool.count
        let object = self.object.count
        
        return (string, int, bool, object)
    }
}
