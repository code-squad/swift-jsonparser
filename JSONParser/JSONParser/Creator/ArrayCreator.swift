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
            guard let notNilData = Converter.convertToArray(string: data) else {continue}
            jsonData.append(notNilData)
        }
        return JsonArray.init(jsonData)
    }
}
