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
            showObject(object: object.data())
        case .array:
            guard let array = jsonData as? JsonArray else {return}
            showArray(array: array.data())
        default:
            return
        }
    }
    
    static private func showObject(object:[String:JsonType]) {
        var jsonFormObject = ""
        
        jsonFormObject.append("{")
        for data in object {
            jsonFormObject.append("\n\t")
            jsonFormObject.append("\"\(data.key)\": \(showRawData(data: data.value)),")
        }
        jsonFormObject.removeLast()
        jsonFormObject.append("\n}")
        
        print(jsonFormObject)
    }
    
    static private func showArray(array:[JsonType]) {
        var jsonFormArray = ""
        
        jsonFormArray.append("[")
        for data in array {
            jsonFormArray.append("\(showRawData(data: data))")
            jsonFormArray.append(",\n\t")
        }
        jsonFormArray.removeLast()
        jsonFormArray.removeLast()
        jsonFormArray.removeLast()
        jsonFormArray.append("\n]")
        
        print(jsonFormArray)
    }
    
    static private func showRawData(data:JsonType) -> String {
        switch data.type() {
        case .string:
            guard let string = data as? JsonString else {return ""}
            return "\"\(string.data())\""
        case .number:
            guard let number = data as? JsonNumber else {return ""}
            return "\(Int(number.data()))"
        case .bool:
            guard let bool = data as? JsonBool else {return ""}
            return "\(bool.data())"
        case .array:
            guard let array = data as? JsonArray else {return ""}
            return "\(showRawArray(array: array.data()))"
        case .object:
            guard let object = data as? JsonObject else {return ""}
            return "\(showRawObject(object: object.data()))"
        }
    }
    
    static private func showRawObject(object:[String:JsonType]) -> String {
        var jsonFormObject = ""
        
        jsonFormObject.append("{")
        for data in object {
            jsonFormObject.append("\n\t\t\"\(data.key)\": \(showRawData(data: data.value))")
        }
        jsonFormObject.append("\n\t}")
        
        return jsonFormObject
    }
    
    static private func showRawArray(array:[JsonType]) -> String {
        var jsonFormArray = ""
        
        jsonFormArray.append("[")
        for data in array {
            jsonFormArray.append("\(showRawData(data: data))")
            jsonFormArray.append(", ")
        }
        jsonFormArray.removeLast()
        jsonFormArray.removeLast()
        jsonFormArray.append("]")
        
        return jsonFormArray
    }
}
