//
//  SwiftArray.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JsonArray : JsonType, JsonCollection {
    private var _data = [JsonType]()
    
    init(array:String) {
        self._data = makeArray(string: array)
    }
    
    private func makeArray(string:String) -> [JsonType]{
        let removedSquare = string.trimmingCharacters(in: ["[","]"])
        let extractedData = RegularExpression.extractData(string: removedSquare)
        var jsonArray = [JsonType]()
        
        for data in extractedData {
            guard let parsedData = Parser.convert(string: data) else {print("지원하지 않는 형식을 포함하고 있습니다.");break}
            jsonArray.append(parsedData)
        }
        return jsonArray
    }
    
    func data() -> [JsonType] {
        return self._data
    }
    
    func numberByType() -> NumberByType {
        return NumberByType.init(array: self._data)
    }
    
    func type() -> TypeInfo {
        return .array
    }
}

