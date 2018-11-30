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
        var JSONFormArray = basicArrayForm(option: ", ")
        JSONFormArray.append("]")
        return JSONFormArray
    }
    
    func printForm() -> String {
        var JSONFormArray = basicArrayForm(option: ",\n\t")
        JSONFormArray.append("\n]")
        return JSONFormArray
    }
    
    private func basicArrayForm(option:String) -> String {
        var JSONFormArray = ""
        
        JSONFormArray.append("[")
        for data in array {
            JSONFormArray.append("\(data.JSONForm())")
            JSONFormArray.append("\(option)")
        }
        for _ in 0..<option.count {
            JSONFormArray.removeLast()
        }
        
        return JSONFormArray
    }
}
