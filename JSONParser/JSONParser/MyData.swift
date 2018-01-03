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
    
    struct Marks {
        static let whiteSpace = " "
        static let leftBracketOfObject = "{"
        static let rightBracketOfObject = "}"
        static let leftBracketOfArray = "["
        static let rightBracketOfArray = "]"
        static let markOfString = "\""
        static let markOfObject = ":"
    }
    
    func sliceByString(from:String, to:String) -> String? {
        let startRange = self.range(of: from)
        guard let firstRange = startRange else {return ""}
        
        let endRange = self.range(of: to)
        guard let secondRange = endRange else {return ""}
        return String(self[firstRange.upperBound..<secondRange.lowerBound])
    }
    
    func makeDataType(_ userData: String) -> MyValues {
        return sliceOneMark(userData, mark: Marks.markOfString)
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
        let valuesInArray = dataWithoutMarks.sliceByString(from: Marks.leftBracketOfArray, to: Marks.rightBracketOfArray)
        let valuesInObject = dataWithoutMarks.sliceByString(from: Marks.leftBracketOfObject, to: Marks.rightBracketOfObject)
        temp = dataWithoutMarks.replacingOccurrences(of: valuesInArray ?? "", with: Marks.whiteSpace)
        temp = temp.replacingOccurrences(of: valuesInObject ?? "", with: Marks.whiteSpace)
        var seperatedData = temp.split(separator: ",").map(String.init)
        for index in 0..<seperatedData.count {
            if isObject(seperatedData[index]) {
                seperatedData[index] = "\(Marks.leftBracketOfObject)\(valuesInObject ?? "")\(Marks.rightBracketOfObject)"
            }
        }
        for index in 0..<seperatedData.count {
            if isArray(self) && seperatedData[index].contains(Marks.leftBracketOfArray) && isObject(seperatedData[index]) == false {
                seperatedData[index] = Marks.leftBracketOfArray + (valuesInArray ?? "") + Marks.rightBracketOfArray
                continue
            }
            guard isObject(self) == true else { continue }
            seperatedData[index] = seperatedData[index].replacingOccurrences(of: Marks.leftBracketOfArray, with: "\(valuesInArray ?? "")\(Marks.rightBracketOfArray)")
        }
        return seperatedData
    }
    
    private func isNumber (_ oneData : String) -> Bool {
        return oneData.components(separatedBy: CharacterSet.decimalDigits).count > 0
    }
    
    private func isStringType (_ oneData : String) -> Bool {
        return oneData.first == Character(Marks.markOfString) && oneData.last == Character(Marks.markOfString)
    }
    
    private func isBoolType (_ oneData : String) -> Bool {
        return oneData == "true" || oneData == "false"
    }
    
    private func isArray (_ oneData : String) -> Bool {
        return oneData.first == Character(Marks.leftBracketOfArray)
    }
    
    private func isObject (_ oneData : String) -> Bool {
        return oneData.first == Character(Marks.leftBracketOfObject)
    }
    
    func generateOneObjectData() -> (key : String, value : MyValues) {
        var databeforeSeperating = self.split(separator: Character(Marks.markOfObject)).map(String.init)
        let tempKey = self.sliceMarks(databeforeSeperating[0])
        let tempValue = self.checkDataType().makeDataType(databeforeSeperating[1])
        return (tempKey, tempValue)
    }
    
    func sliceOneMark (_ fullString : String, mark : String) -> String {
        var temp = ""
        let stringsWithoutMark : [String] = fullString.split(separator: Character(mark)).map(String.init)
        for index in 0..<stringsWithoutMark.count {
            temp += stringsWithoutMark[index]
        }
        return temp
    }
    
    func sliceMarks (_ userInput : String) -> String {
        var userInputWithoutBracket = sliceOneMark(userInput, mark: Marks.whiteSpace)
        if isArray(userInputWithoutBracket) || isObject(userInputWithoutBracket) || isStringType(userInputWithoutBracket) {
            userInputWithoutBracket.removeFirst()
            userInputWithoutBracket.removeLast()
        }
        return userInputWithoutBracket
    }
}
