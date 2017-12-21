//
//  DataFactory.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 19..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation
typealias ObjectDictionary = [String : Any]

struct DataFactory {
    
    func generateData (_ data : String) -> MyData {
        let dataBeforeSeperating = sliceData(data)
        var seperatedArray : [Any] = []
        var seperatedObeject : [String:Any] = [:]
        var temp : ( key : String, value : Any )
        for indexOfData in 0..<dataBeforeSeperating.count {
            if isArray(data) == true {
                seperatedArray.append(makeOneData(dataBeforeSeperating[indexOfData]))
                continue
            }
            temp = makeObjectType(dataBeforeSeperating[indexOfData])
            seperatedObeject.updateValue(temp.value, forKey: temp.key)
        }
        guard isArray(data) == false else { return MyArray.init(seperatedArray) }
        return MyDictionary.init(seperatedObeject)
    }
    
    private func makeOneData (_ oneData : String) -> Any {
        guard isBoolType(oneData) == false else { return makeBoolType(oneData) }
        guard isStringType(oneData) == false else { return sliceMarks(oneData) }
        if isObject(oneData) == true {
            let temp = makeObjectType(oneData)
            return MyDictionary.init([temp.key : temp.value])
        }
        return Int(oneData) ?? 0
    }
    
    private func makeObjectType (_ oneData : String) -> (key : String, value : Any) {
        var databeforeSeperating = oneData.split(separator: ":").map(String.init)
        let tempKey = sliceMarks(databeforeSeperating[0])
        let tempValue = makeOneData(databeforeSeperating[1])
        return (tempKey, tempValue)
    }
    
    private func makeBoolType (_ oneData : String ) -> Bool {
        return oneData == "true"
    }
    
    private func isNumber (_ oneData : String) -> Bool {
        return oneData.components(separatedBy: CharacterSet.decimalDigits).count != 0
    }
    
    private func isStringType (_ oneData : String) -> Bool {
        return oneData.first == "\"" && oneData.last == "\""
    }
    
    private func isBoolType (_ oneData : String) -> Bool {
        return oneData == "true" || oneData == "false"
    }
    
    private func isArray (_ oneData : String) -> Bool {
        return oneData.first == "["
    }
    
    private func isObject (_ oneData : String) -> Bool {
        return oneData.first == "{"
    }
    
    private func sliceData (_ data : String) -> [String] {
        let temp = sliceMarks(data)
        return temp.split(separator: ",").map(String.init)
    }
    
    private func sliceMarks (_ userInput : String) -> String {
        var userInputWithoutBracket = sliceOneMark(userInput, mark: " ")
        userInputWithoutBracket.removeFirst()
        userInputWithoutBracket.removeLast()
        return userInputWithoutBracket
    }
    
    private func sliceOneMark (_ fullString : String, mark : Character) -> String {
        var temp = ""
        let stringsWithoutMark : [String] = fullString.split(separator: mark).map(String.init)
        for index in 0..<stringsWithoutMark.count {
            temp += stringsWithoutMark[index]
        }
        return temp
    }

}
