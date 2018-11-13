//
//  ArrayCreator.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 13..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct ArrayCreator : Creator {
    func removeBracket(_ jsonData:String) -> String {
        return jsonData.trimmingCharacters(in: ["[","]"])
    }
    
    func sortByType(_ inputData:[String]) -> Collection {
        var jsonData = [UsableType]()
        
        for data in inputData {
            switch data.isWhatForm() {
            case "string":
                jsonData.append(data.removeDoubleQuotationMarks())
            case "number":
                jsonData.append(Double(data) ?? 0)
            case "bool":
                jsonData.append(data.isTrue())
            default:
                continue
            }
        }
        return SwiftArray.init(jsonData)
    }
}
