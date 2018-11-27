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
    
    init(array:[JsonType]) {
        self._data = array
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
