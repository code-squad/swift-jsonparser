//
//  DataFactory.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 19..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct DataFactory {
    
    func generateDataAndCount (_ userInput : String) -> (data : [Any], countVal : (stringVal : Int, numberVal : Int, boolVal : Int)) {
        let userDataWithoutMarks = sliceMarks(userInput)
        let dataSeperated = seperateData(userDataWithoutMarks)
        let numbersOfObjects = countNumberOfObjects(userData: dataSeperated)
        return (dataSeperated, numbersOfObjects)
    }
    
    private func seperateData (_ dataWithoutMarks : String) -> [Any] {
        let dataBeforeSeperating = dataWithoutMarks.split(separator: ",").map(String.init)
        var temp : [Any] = []
        for indexOfData in 0..<dataBeforeSeperating.count {
            temp.append(seperateOneData(oneData: dataBeforeSeperating[indexOfData]))
        }
        return temp
    }
    
    private func seperateOneData (oneData : String) -> Any {
        guard isBoolType(oneData) == false else { return makeBoolType(oneData) }
        guard isStringType(oneData) == false else { return makeStringType(oneData) }
        guard isNumber(oneData) == false else { return Int(oneData) ?? 0 }
        return ""
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
    
    private func makeStringType (_ oneData : String) -> String {
        var temp = oneData
        temp.removeFirst()
        temp.removeLast()
        return temp
    }
    
    private func makeBoolType (_ oneData : String ) -> Bool {
        return oneData == "true"
    }
    
    private func sliceMarks (_ userInput : String) -> String {
        let userInputWithoutEmpty = sliceOneMark(userInput, mark: " ")
        let userInputWithoutLeftMark = sliceOneMark(userInputWithoutEmpty, mark: "[")
        return sliceOneMark(userInputWithoutLeftMark, mark: "]")
    }
    
    private func sliceOneMark (_ fullString : String, mark : Character) -> String {
        var temp = ""
        let stringsWithoutMark : [String] = fullString.split(separator: mark).map(String.init)
        for index in 0..<stringsWithoutMark.count {
            temp += stringsWithoutMark[index]
        }
        return temp
    }
    
    private func countNumberOfObjects(userData : [Any]) -> (stringVal : Int, numberVal : Int, boolVal : Int) {
        var temp : (stringVal : Int, numberVal : Int, boolVal : Int) = (0,0,0)
        for oneData in userData {
            switch oneData {
            case is String : temp.stringVal += 1
            case is Int : temp.numberVal += 1
            case is Bool : temp.boolVal += 1
            default : break
            }
        }
        return temp
    }
}
