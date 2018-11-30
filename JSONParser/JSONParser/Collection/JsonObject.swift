//
//  SwiftObject.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 13..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JsonObject : JsonType, JsonCollection, ShowAble {
    private var _data = [String:JsonType]()
    
    init(object:[String:JsonType]) {
        self._data = object
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
    
    func bracket() -> (String, String) {
        return ("{","}")
    }
    
    func JSONForm() -> String {
        return ""
    }
}
