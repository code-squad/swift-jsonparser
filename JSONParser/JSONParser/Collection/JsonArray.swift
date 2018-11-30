//
//  SwiftArray.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JsonArray : JsonType, JsonCollection, PrintAble {
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
    
    func bracket() -> (String, String) {
        return ("[","]")
    }
    
    func JSONForm() -> String {
        var JSONFormArray = ""
        
        JSONFormArray.append("[")
        for data in _data {
            JSONFormArray.append("\(data.JSONForm())")
            JSONFormArray.append(", ")
        }
        JSONFormArray.removeLast()
        JSONFormArray.removeLast()
        JSONFormArray.append("]")
        
        return JSONFormArray
    }
    
    func printForm() -> String {
        var JSONFormArray = ""
        
        JSONFormArray.append("[")
        for data in _data {
            JSONFormArray.append("\(data.JSONForm())")
            JSONFormArray.append(",\n\t")
        }
        JSONFormArray.removeLast()
        JSONFormArray.removeLast()
        JSONFormArray.removeLast()
        JSONFormArray.append("\n]")
        
        return JSONFormArray
    }
}
