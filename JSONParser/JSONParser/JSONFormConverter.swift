//
//  JSONFormConverter.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONFormConverter {
    static func show(rawData:JsonType) -> String {
        switch rawData.type() {
        case .string:
            guard let string = rawData as? JsonString else {return ""}
            return "\"\(string.data())\""
        case .number:
            guard let number = rawData as? JsonNumber else {return ""}
            return "\(Int(number.data()))"
        case .bool:
            guard let bool = rawData as? JsonBool else {return ""}
            return "\(bool.data())"
        case .array:
            guard let array = rawData as? JsonArray else {return ""}
            return "\(show(rawArray: array.data()))"
        case .object:
            guard let object = rawData as? JsonObject else {return ""}
            return "\(show(rawObject: object.data()))"
        }
    }
    
    static private func show(rawObject:[String:JsonType]) -> String {
        var JSONFormObject = ""
        
        JSONFormObject.append("{")
        for data in rawObject {
            JSONFormObject.append("\n\t\t\"\(data.key)\": \(show(rawData: data.value))")
        }
        JSONFormObject.append("\n\t}")
        
        return JSONFormObject
    }
    
    static private func show(rawArray:[JsonType]) -> String {
        var JSONFormArray = ""
        
        JSONFormArray.append("[")
        for data in rawArray {
            JSONFormArray.append("\(show(rawData: data))")
            JSONFormArray.append(", ")
        }
        JSONFormArray.removeLast()
        JSONFormArray.removeLast()
        JSONFormArray.append("]")
        
        return JSONFormArray
    }
}
