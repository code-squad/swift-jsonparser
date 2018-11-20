//
//  SwiftArray.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JsonArray : JsonType, JsonCollection {
    private let arrayBeforeConvert : String
    private var array : Array = [ArrayUsableType]()
    
    init(string:String) {
        self.arrayBeforeConvert = string
        self.convertData()
    }
    
    mutating func convertData() {
        let removedSquare = arrayBeforeConvert.trimmingCharacters(in: ["[","]"])
        let extractedData = RegularExpression.extractData(string: removedSquare)
        
        for data in extractedData {
            guard let parsedData = Parser.convert(string: data) as? ArrayUsableType else {continue}
            guard parsedData.checkAvailable() else {continue}
            self.array.append(parsedData)
        }
    }
    
    func checkAvailable() -> Bool {
        return self.array.count != 0
    }
    
    func numberByType() -> NumberByType {
        return self.array.numberByType()
    }
    
    func type() -> String {
        return "배열"
    }
}

