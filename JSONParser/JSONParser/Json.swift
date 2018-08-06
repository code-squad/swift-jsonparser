//
//  Json.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 4..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct Json {
    private var string:Int
    private var int:Int
    private var bool:Int
    private var total:Int

    init() {
        self.string = 0
        self.int = 0
        self.bool = 0
        self.total = 0
    }
    
    public mutating func addString() {
        self.string = self.string + 1
    }
    
    public mutating func addInt() {
        self.int = self.int + 1
    }
    
    public mutating func addBool() {
        self.bool = self.bool + 1
    }
    
    public func countJson() -> Dictionary<String,Int> {
        var counts : [String: Int] = [:]
        counts.updateValue(self.string, forKey: "문자열")
        counts.updateValue(self.int, forKey: "숫자")
        counts.updateValue(self.bool, forKey: "부울")
        counts.updateValue(self.string + self.int + self.bool, forKey: "총")
        return counts
    }
}
