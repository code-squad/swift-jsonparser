//
//  TypeIdentifier.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 9..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct TypeIdentifier {

    func matchType (_ values: [String]) -> [JSONData] {
        var parsedJSONData : [JSONData] = []
        
        for value in values {
            if let boolValue = Bool(value) {
                parsedJSONData.append(JSONData.BoolValue(boolValue))
                continue
            }
            if let intValue = Int(value) {
                parsedJSONData.append(JSONData.IntegerValue(intValue))
                continue
            }
            if value.contains("\""){
                parsedJSONData.append(JSONData.StringValue(value))
                continue
            }
        }
        return parsedJSONData
    }

}


