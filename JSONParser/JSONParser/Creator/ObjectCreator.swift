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
    
    func sortByType(_ inputData: [String]) -> JsonCollection {
        var jsonData = [String:ObjectUsableType]()
        
        for index in stride(from: inputData.startIndex, through: inputData.endIndex - 1, by: 2) {
            switch Converter.convertToSwiftType(string: inputData[index + 1]) {
            case .string:
                jsonData[inputData[index]] = inputData[index + 1].removeDoubleQuotationMarks()
            case .number:
                jsonData[inputData[index]] = Double(inputData[index + 1])
            case .bool:
                jsonData[inputData[index]] = inputData[index + 1].isTrue()
            case .object,.none:
                continue
            }
        }
        return JsonObject.init(jsonData)
    }
}
