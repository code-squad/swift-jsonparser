//
//  SwiftObject.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 13..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JsonObject : JsonType, JsonCollection, PrintAble {
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
        var JSONFormObject = ""
        
        JSONFormObject.append("{")
        for data in _data {
            JSONFormObject.append("\n\t\t\"\(data.key)\": \(data.value.JSONForm())")
        }
        JSONFormObject.append("\n\t}")
        
        return JSONFormObject
    }
    
    func printForm() -> String {
        var JSONFormObject = ""
        
        JSONFormObject.append("{")
        for data in _data {
            JSONFormObject.append("\n\t")
            JSONFormObject.append("\"\(data.key)\": \(data.value.JSONForm()),")
        }
        JSONFormObject.removeLast()
        JSONFormObject.append("\n}")
        
        return JSONFormObject
    }
}
