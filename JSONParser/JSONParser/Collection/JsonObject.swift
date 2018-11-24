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
        self._data = makeObject(string: object)
    }
    
    private func makeObject(string:String) -> [String:JsonType] {
        let removedSquare = string.trimmingCharacters(in: ["{","}"])
        let extractedData = RegularExpression.extractData(string: removedSquare)
        var jsonObject = [String:JsonType]()
        
        for index in stride(from: extractedData.startIndex, through: extractedData.endIndex - 1, by: 2) {
            guard let keyData = Parser.convert(string:extractedData[index]) as? JsonString
                else {print("지원하지 않는 형식을 포함하고 있습니다.");break}
            guard let valueData = Parser.convert(string:extractedData[index + 1])
                else {print("지원하지 않는 형식을 포함하고 있습니다.");break}
            jsonObject[keyData.data()] = valueData
        }
        
        return jsonObject
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
