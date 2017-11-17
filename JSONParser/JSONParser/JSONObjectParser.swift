//
//  JSONObjectParser.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 15..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation
// JSONParser for Object
extension JSONParser {
    func makeObjectJSONData(_ rawJSON: String) -> JSONData {
        var objectTypeJSON = [String:JSONType]()
        let removedBrace = supportingJSON.processBeforeMakingJSON(rawJSON)
        let separateJSON = removedBrace.components(separatedBy: ",")
        for objectComponents in separateJSON {
            let separateObject = objectComponents.components(separatedBy: ":")
            let key = supportingJSON.hasStringType(separateObject[0].trimmingCharacters(in: .whitespacesAndNewlines))
            let objectValue = separateObject[1].trimmingCharacters(in: .whitespacesAndNewlines)
            objectTypeJSON[key] = supportingJSON.sortJSONData(objectValue)
        }
        return JSONData(objectTypeJSON)
    }
    
}
