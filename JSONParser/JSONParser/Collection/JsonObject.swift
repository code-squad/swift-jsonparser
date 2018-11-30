//
//  SwiftObject.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 13..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JsonObject : JsonType, JsonCollection, PrintAble {
    private var object = [String:JsonType]()
    
    init(object:[String:JsonType]) {
        self.object = object
    }
    
    func numberByType() -> NumberByType {
        return NumberByType.init(array: Array(self.object.values))
    }
    
    func type() -> TypeInfo {
        return .object
    }
    
    func bracket() -> (String, String) {
        return ("{","}")
    }
    
    func JSONForm() -> String {
        return basicForm(option: "\t")
    }
    
    func printForm() -> String {
        return basicForm(option: "")
    }
    
    private func basicForm(option:String) -> String {
        var JSONFormObject = ""
        
        JSONFormObject.append("{")
        for data in object {
            JSONFormObject.append("\n\t\(option)\"\(data.key)\": \(data.value.JSONForm()),")
        }
        JSONFormObject.removeLast()
        JSONFormObject.append("\n\(option)}")
        
        return JSONFormObject
    }
}
