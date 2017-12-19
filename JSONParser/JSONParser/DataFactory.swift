//
//  DataFactory.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 19..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct DataFactory {
    
    func seperateData (_ userData : String) -> [Any] {
        var dataSeperated = userData.split(separator: ",").map(String.init)
        var temp : [Any] = []
        for indexOfData in 0..<dataSeperated.count {
            temp.append(seperateOneData(oneData: dataSeperated[indexOfData]))
        }
        return temp
    }
    
    func seperateOneData (oneData : String) -> Any {
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
    
    private func makeStringType (_ oneData : String) -> String {
        var temp = oneData
        temp.removeFirst()
        temp.removeLast()
        return temp
    }
    
    private func isBoolType (_ oneData : String) -> Bool {
        return oneData == "true" || oneData == "false"
    }
    
    private func makeBoolType (_ oneData : String ) -> Bool {
        return oneData == "true"
    }
}
