//
//  SwiftObject.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 13..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JsonObject : JsonType, JsonCollection {
    private var _data = [String:JsonType]()
    
    init(object:String) {
        makeObject(string: object)
    }
    
    mutating private func makeObject(string:String) {
        let removedSquare = string.trimmingCharacters(in: ["{","}"])
        let extractedData = RegularExpression.extractData(string: removedSquare)
        
        for index in stride(from: extractedData.startIndex, through: extractedData.endIndex - 1, by: 2) {
            guard let keyData = Parser.convert(string:extractedData[index]) as? JsonString else {continue}
            guard let valueData = Parser.convert(string:extractedData[index + 1]) else {continue}
            self._data[keyData.data()] = valueData
        }
    }
    
    func data() -> [String:JsonType] {
        return self._data
    }
    
    func numberByType() -> NumberByType {
        return NumberByType.init(array: Array(self._data.values))
    }
    
    func type() -> TypeInfo {
        return .object
    }
}
