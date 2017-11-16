//
//  ParserSupporting.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 15..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation
// protocol Extensions 
struct JSONSupporting {
    func processBeforeMakingJSON(_ value: String) -> String {
        var rawJSON = value
        rawJSON.removeFirst()
        rawJSON.removeLast()
        return rawJSON
    }
    
    func sortJSONType(_ value: [String]) -> [Any] {
        var jsonData = [Any]()
        for sortedJSON in value {
            jsonData.append(sortJSONData(sortedJSON))
        }
        return jsonData
    }
    
    func sortJSONData(_ value: String) -> JSONType {
        var rawJSON = value
        if let boolType = Bool(rawJSON) {
            return JSONType.boolType(boolType)
        } else if let intType = Int(rawJSON) {
            return JSONType.intType(intType)
        } else {
            rawJSON.removeFirst()
            rawJSON.removeLast()
            return JSONType.stringType(rawJSON)
        }
    }
    
    func hasStringType(_ value: String) -> String {
        var pureString = value
        pureString.removeFirst()
        pureString.removeLast()
        return pureString
    }

}
