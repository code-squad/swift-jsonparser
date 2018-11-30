//
//  SwiftArray.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JsonArray : JsonType, JsonCollection, PrintAble {
    private var array = [JsonType]()
    
    init(array:[JsonType]) {
        self.array = array
    }
    
    func data() -> [JsonType] {
        return self.array
    }
    
    func numberByType() -> NumberByType {
        return NumberByType.init(array: self.array)
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
        for data in array {
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
        for data in array {
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
