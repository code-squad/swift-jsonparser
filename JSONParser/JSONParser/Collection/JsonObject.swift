//
//  SwiftObject.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 13..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JsonObject : JsonType, JsonCollection {
    private let objectBeforeConvert : String
    private var object : Dictionary = [String:JsonType]()
    
    init(string:String) {
        self.objectBeforeConvert = string
        self.convertData()
    }
    
    mutating func convertData() {
        let removedSquare = objectBeforeConvert.trimmingCharacters(in: ["{","}"])
        let extractedData = RegularExpression.extractData(string: removedSquare)
        
        for index in stride(from: extractedData.startIndex, through: extractedData.endIndex - 1, by: 2) {
            guard let keyData = Parser.convert(string:extractedData[index]) as? JsonString else {continue}
            guard let valueData = Parser.convert(string:extractedData[index + 1]) else {continue}
            guard keyData.checkAvailable() && valueData.checkAvailable() else {continue}
            object[keyData.readData()] = valueData
        }
    }
    
    func checkAvailable() -> Bool {
        return self.object.count != 0
    }
    
    func numberByType() -> NumberByType {
        return Array(self.object.values).numberByType()
    }
    
    func type() -> String {
        return "객체"
    }
}
