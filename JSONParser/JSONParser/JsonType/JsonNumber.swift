//
//  JsonNumber.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 19..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JsonNumber: JsonType, ArrayUsableType, ObjectUsableType {
    private let numberBeforeConvert : String
    private var number : Double? = nil
    
    init(string:String) {
        self.numberBeforeConvert = string
        self.convertData()
    }
    
    mutating func convertData() {
        self.number = Double(self.numberBeforeConvert)
    }
    
    func checkAvailable() -> Bool {
        return self.number != nil
    }
}
