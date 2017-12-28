//
//  DataFactory.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 19..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation
typealias ObjectDictionary = [String : Any]

extension String {
    
    func sliceByString(from:String, to:String) -> String? {
        let startRange = self.range(of: from)
        guard let firstRange = startRange else {return ""}
        let subString = String(self[firstRange.upperBound...])
        
        let endRange = subString.range(of: to)
        guard let secondRange = endRange else {return ""}
        return String(subString[..<secondRange.lowerBound])
    }
    
}

struct DataFactory {
    
    func generateData (_ data : String) -> Any {
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
        print(seperatedArray)
        print(seperatedObeject)
        guard isArray(data) == false else { return seperatedArray }
        return seperatedObeject
    }
    
    private func makeOneData (_ oneData : String) -> Any {
        if isObject(oneData) == true {
            let temp = makeObjectType(oneData)
            return [temp.key : temp.value]
        }
        guard isArray(oneData) == false else { return generateData(oneData) }
        guard isBoolType(oneData) == false else { return makeBoolType(oneData) }
        guard isStringType(oneData) == false else { return makeStringType(oneData) }
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
    
    private func makeStringType (_ oneData : String) -> String {
        return sliceOneMark(oneData, mark: "\"")
    }
    
    private func isNumber (_ oneData : String) -> Bool {
        return oneData.components(separatedBy: CharacterSet.decimalDigits).count > 0
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
    
    private func isInnerArray(_ oneData : String) -> Bool {
        return oneData.first == "/"
    }
    
    private func isObject (_ oneData : String) -> Bool {
        return oneData.first == "{"
    }
    
    private func sliceData (_ data : String) -> [String] {
        let dataWithoutMarks = sliceMarks(data)
        let valuesInArray = dataWithoutMarks.sliceByString(from: "[", to: "]")
        let temp = dataWithoutMarks.replacingOccurrences(of: valuesInArray!, with: " ", range: nil)
        var seperatedData = temp.split(separator: ",").map(String.init)
        for index in 0..<seperatedData.count {
            if isArray(data) == true && seperatedData[index].contains("[") {
               seperatedData[index] = "[" + valuesInArray! + "]"
               break
            }
            seperatedData[index] = seperatedData[index].replacingOccurrences(of: "]", with: valuesInArray! + "]")
        }
        return seperatedData
    }
    
    private func sliceMarks (_ userInput : String) -> String {
        var userInputWithoutBracket = sliceOneMark(userInput, mark: " ")
        if isArray(userInputWithoutBracket) || isObject(userInputWithoutBracket) || isStringType(userInputWithoutBracket) {
        userInputWithoutBracket.removeFirst()
        userInputWithoutBracket.removeLast()
        }
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
