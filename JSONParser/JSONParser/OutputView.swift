//
//  Check.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct OutputView {
    static func showNumberOfData(_ number:NumberByType, type:TypeInfo) {
        guard number.numberOfAll() > 0 else {print("데이터가 없습니다."); return}
        
        print("총 \(number.numberOfAll())개의 \(type.rawValue) 데이터 중에", terminator: "")
        showResult(readInfo(number))
        print("가 포함되어 있습니다.", terminator: "")
        print("")
    }
    
    static private func readInfo(_ number:NumberByType) -> [String] {
        var outputArray = [String]()
        if number.numberOfString() > 0 {
            outputArray.append(" 문자열 \(number.numberOfString())개")
        }
        if number.numberOfNumber() > 0 {
            outputArray.append(" 숫자 \(number.numberOfNumber())개")
        }
        if number.numberOfBool() > 0 {
            outputArray.append(" 부울 \(number.numberOfBool())개")
        }
        if number.numberOfObject() > 0 {
            outputArray.append(" 객체 \(number.numberOfObject())개")
        }
        if number.numberOfArray() > 0 {
            outputArray.append(" 배열 \(number.numberOfArray())개")
        }
        return outputArray
    }
    
    static private func showResult(_ result:[String]) {
        for numberOfData in result {
            print(numberOfData, terminator: "")
            guard numberOfData != result[result.endIndex - 1] else {continue}
            print(",", terminator: "")
        }
    }
    
    static func showJsonForm(_ jsonData:JsonCollection) {
        switch jsonData.type() {
        case .object:
            guard let object = jsonData as? JsonObject else {return}
            show(object: object.data())
        case .array:
            guard let array = jsonData as? JsonArray else {return}
            show(array: array.data())
        default:
            return
        }
    }
    
    static private func show(object:[String:JsonType]) {
        var JSONFormObject = ""
        
        JSONFormObject.append("{")
        for data in object {
            JSONFormObject.append("\n\t")
            JSONFormObject.append("\"\(data.key)\": \(show(rawData: data.value)),")
        }
        JSONFormObject.removeLast()
        JSONFormObject.append("\n}")
        
        print(JSONFormObject)
    }
    
    static private func show(array:[JsonType]) {
        var JSONFormArray = ""
        
        JSONFormArray.append("[")
        for data in array {
            JSONFormArray.append("\(show(rawData: data))")
            JSONFormArray.append(",\n\t")
        }
        JSONFormArray.removeLast()
        JSONFormArray.removeLast()
        JSONFormArray.removeLast()
        JSONFormArray.append("\n]")
        
        print(JSONFormArray)
    }
    
    static private func show(rawData:JsonType) -> String {
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
