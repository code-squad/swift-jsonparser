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
    
    func sortByType(_ inputData:[String]) -> JsonCollection {
        var jsonData = [ArrayUsableType]()
        
        for data in inputData {
            switch JsonAnalysis.convertToSwiftType(string: data) {
            case .string:
                jsonData.append(data.removeDoubleQuotationMarks())
            case .number:
                jsonData.append(Double(data) ?? 0)
            case .bool:
                jsonData.append(data.isTrue())
            case .object:
                jsonData.append(createObject(data))
            case .none:
                continue
            }
        }
        return JsonArray.init(jsonData)
    }
    
    private func createObject(_ data:String) -> [String:ArrayUsableType] {
        let creator = CollectionCreator.init(ObjectCreator())
        return creator.create(data) as? [String : ArrayUsableType] ?? ["":""]
    }
}
