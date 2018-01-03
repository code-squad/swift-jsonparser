//
//  MyData.swift
//  JSONParser
//
//  Created by jack on 2018. 1. 3..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

protocol MyValues {
    
    func makeDataType(_ userData : String) -> MyValues
    
}
extension Bool : MyValues {
    
    func makeDataType(_ userData: String) -> MyValues {
            return userData == "true"
        }
    
}

extension Int : MyValues {
    
    func makeDataType(_ userData: String) -> MyValues {
        return Int(userData) ?? 0
    }
    
}

extension Array : MyValues {
    
    func makeDataType(_ userData: String) -> MyValues {
        return userData.sliceData()
    }
    
}

extension Dictionary : MyValues {
    
    func makeDataType(_ userData: String) -> MyValues {
        var temp : ( key : String, value : MyValues )
        var tempDic : ObjectDictionary = [:]
        let seperatedObject = userData.sliceData()
        for index in 0..<seperatedObject.count {
            temp = seperatedObject[index].generateOneObjectData()
            tempDic.updateValue(temp.value, forKey: temp.key)
        }
        return tempDic
    }

}

extension String : MyValues {
    
    func sliceByString(from:String, to:String) -> String? {
        let startRange = self.range(of: from)
        guard let firstRange = startRange else {return ""}
        
        let endRange = self.range(of: to)
        guard let secondRange = endRange else {return ""}
        return String(self[firstRange.upperBound..<secondRange.lowerBound])
    }
    
    func makeDataType(_ userData: String) -> MyValues {
        return sliceOneMark(userData, mark: "\"")
    }
    
    func checkDataType() -> MyValues {
            switch self {
            case self where isObject(self) : return [:].makeDataType(self)
            case self where isArray(self) : return self.sliceData()
            case self where isBoolType(self) : return Bool().makeDataType(self)
            case self where isStringType(self) : return self.makeDataType(self)
            default:
                return Int().makeDataType(self)
            }
        }
    
    func sliceData () -> [String] {
        var temp : String = ""
        let dataWithoutMarks = sliceMarks(self)
        let valuesInArray = dataWithoutMarks.sliceByString(from: "[", to: "]")
        let valuesInObject = dataWithoutMarks.sliceByString(from: "{", to: "}")
        temp = dataWithoutMarks.replacingOccurrences(of: valuesInArray ?? "", with: " ")
        temp = temp.replacingOccurrences(of: valuesInObject ?? "", with: " ")
        var seperatedData = temp.split(separator: ",").map(String.init)
        for index in 0..<seperatedData.count {
            if isObject(seperatedData[index]) {
                seperatedData[index] = "{\(valuesInObject ?? "")}"
            }
        }
        for index in 0..<seperatedData.count {
            if isArray(self) && seperatedData[index].contains("[") && isObject(seperatedData[index]) == false {
                seperatedData[index] = "[" + (valuesInArray ?? "") + "]"
                continue
            }
            guard isObject(self) == true else { continue }
            seperatedData[index] = seperatedData[index].replacingOccurrences(of: "]", with: "\(valuesInArray ?? "")]")
        }
        return seperatedData
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
    
    private func isObject (_ oneData : String) -> Bool {
        return oneData.first == "{"
    }
    
    func generateOneObjectData() -> (key : String, value : MyValues) {
        var databeforeSeperating = self.split(separator: ":").map(String.init)
        let tempKey = self.sliceMarks(databeforeSeperating[0])
        let tempValue = self.checkDataType().makeDataType(databeforeSeperating[1])
        return (tempKey, tempValue)
    }
    
    func sliceOneMark (_ fullString : String, mark : Character) -> String {
        var temp = ""
        let stringsWithoutMark : [String] = fullString.split(separator: mark).map(String.init)
        for index in 0..<stringsWithoutMark.count {
            temp += stringsWithoutMark[index]
        }
        return temp
    }
    
    func sliceMarks (_ userInput : String) -> String {
        var userInputWithoutBracket = sliceOneMark(userInput, mark: " ")
        if isArray(userInputWithoutBracket) || isObject(userInputWithoutBracket) || isStringType(userInputWithoutBracket) {
            userInputWithoutBracket.removeFirst()
            userInputWithoutBracket.removeLast()
        }
        return userInputWithoutBracket
    }
}
