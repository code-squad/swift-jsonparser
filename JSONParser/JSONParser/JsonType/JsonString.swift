//
//  JsonString.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 19..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JsonString: JsonType {
    private let stringBeforeConvert : String
    private var string : String? = nil
    
    init(string:String) {
        self.stringBeforeConvert = string
        self.convertData()
    }
    
    mutating func convertData() {
        self.string = self.stringBeforeConvert.removeDoubleQuotationMarks()
    }
    
    func checkAvailable() -> Bool {
        return self.string != nil
    }
    
    func readData() -> String {
        return self.string ?? ""
    }
}
