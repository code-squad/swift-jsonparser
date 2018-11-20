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
            jsonData[inputData[index]] = Parser.convertToObject(string: inputData[index + 1])
        }
        return JsonObject.init(jsonData)
    }
}
