//
//  JsonBool.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 19..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JsonBool: JsonType, ArrayUsableType, ObjectUsableType  {
    private let boolBeforeConvert : String
    private var bool : Bool? = nil
    
    init(string:String) {
        self.boolBeforeConvert = string
        self.convertData()
    }
    
    mutating func convertData() {
        self.bool = self.boolBeforeConvert.isTrue()
    }
    
    func checkAvailable() -> Bool {
        return self.bool != nil
    }
}
