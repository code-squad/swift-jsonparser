//
//  Json.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 4..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct Json {
    private var string:Array<String>
    private var int:Array<Int>
    private var bool:Array<Bool>
    
    init() {
        self.string = []
        self.int = []
        self.bool = []
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
    
    public func count() -> (Int,Int,Int) {
        let string = self.string.count
        let int = self.int.count
        let bool = self.bool.count
        
        return (string, int, bool)
    }
}
