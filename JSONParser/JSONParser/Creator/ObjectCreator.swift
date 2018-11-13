//
//  ObjectCreator.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 13..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct ObjectCreator : Creator {
    func removeBracket(_ jsonData:String) -> String {
        return jsonData.trimmingCharacters(in: ["{","}"])
    }
    
    func sortByType(_ inputData: [String]) -> Collection {
        var jsonData = [String:UsableType]()
        let seperatedInput = seperateKeyAndValue(inputData)
        
        for data in seperatedInput {
            switch data[1].isWhatForm() {
            case "string":
                jsonData[data[0]] = data[1].removeDoubleQuotationMarks()
            case "number":
                jsonData[data[0]] = Double(data[1])
            case "bool":
                jsonData[data[0]] = data[1].isTrue()
            default:
                continue
            }
        }
        return SwiftObject.init(jsonData)
    }
    
    func seperateKeyAndValue(_ input:[String]) -> [[String]] {
        var seperatedInput = [[String]]()
        
        for willSeperateData in input {
            seperatedInput.append(willSeperateData.seperateByColon())
        }
        
        return seperatedInput
    }
}
