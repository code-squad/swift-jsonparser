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
    
    func generateData (_ userInput : String) -> Any {
        if isArray(userInput) == true {
            return generateArray(userInput)
        }
        return generateObject(userInput)
    }
    
    private func generateObject (_ data : String) -> ObjectDictionary {
        let userDataWithoutMarks = sliceMarks(data)
        let dataBeforeSeperating = userDataWithoutMarks.split(separator: ",").map(String.init)
        var seperatedObject : ObjectDictionary = [:]
        var temp : (key : String, value : Any)
        for indexOfData in 0..<dataBeforeSeperating.count {
            temp = makeObjectType(dataBeforeSeperating[indexOfData])
            seperatedObject[temp.key] = temp.value
        }
        return seperatedObject
    }
    
    private func generateArray (_ data : String) -> [Any] {
        let userDataWithoutMarks = sliceMarks(data)
        let dataBeforeSeperating = userDataWithoutMarks.split(separator: ",").map(String.init)
        var seperatedArray : [Any] = []
        for indexOfData in 0..<dataBeforeSeperating.count {
            seperatedArray.append(makeOneData(dataBeforeSeperating[indexOfData]))
        }
        return seperatedArray
    }
    
    private func makeOneData (_ oneData : String) -> Any {
        guard isBoolType(oneData) == false else { return makeBoolType(oneData) }
        guard isStringType(oneData) == false else { return sliceMarks(oneData) }
        guard isNumber(oneData) == false else { return Int(oneData) ?? 0 }
        return makeObjectType(oneData)
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
