//
//  JSONParser.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 13..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONParser: JSONSupporting {
    enum ErrorCode: Error {
        case invalidInputString
        case invalidJSONStandard
        case invalidPatten
    }

    func makeJSONData(_ value: String?) throws -> JSONData {
        guard let safeValue = value else {
            throw ErrorCode.invalidInputString
        }
        let grammarChecker = GrammarChecker()
        if safeValue.hasPrefix("[") {
            let validValue = try grammarChecker.checkAndSeparateArray(inString: safeValue)
            return try makeArrayJSONData(validValue)
        } else if safeValue.hasPrefix("{"){
            let validValue = try grammarChecker.checkAndSeparateObject(inString: safeValue)
            return makeObjectJSONData(validValue)
        } else {
            throw ErrorCode.invalidJSONStandard
        }
    }
    
    private func makeObjectJSONData(_ separateJSON: [String]) -> JSONData {
        var objectTypeJSON = [String:JSONType]()
        for objectComponents in separateJSON {
            let separateObject = objectComponents.components(separatedBy: ":")
            let key = hasStringType(separateObject[0].trimmingCharacters(in: .whitespacesAndNewlines))
            let objectValue = separateObject[1].trimmingCharacters(in: .whitespacesAndNewlines)
            objectTypeJSON[key] = sortJSONData(objectValue)
        }
        return JSONData(objectTypeJSON)
    }
    
    private func makeArrayJSONData(_ value: [String]) throws -> JSONData {
        return JSONData(value.map{ sortJSONData($0) })
    }

}
