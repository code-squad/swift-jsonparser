//
//  JSONParser.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 13..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    static func check(_ value: String?) throws -> String? {
        guard let safeValue = value else {
            throw ErrorCode.invalidInputString
        }
        if safeValue.hasPrefix("[") {
            return safeValue
        } else {
            throw ErrorCode.invalidJSONStandard
        }
    }
    
    func makeJSONData(_ value: String) -> JSONData{
        var rawJSON = value
        rawJSON.removeFirst()
        rawJSON.removeLast()
        let separateJSON = rawJSON.components(separatedBy: ",")
        let removedWhiteSpaceJSON = separateJSON.map {
            (value: String) -> String in
            return value.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        let jsonData = JSONData(sortJSONType(removedWhiteSpaceJSON))
        return jsonData
    }
    
    private func sortJSONType(_ value: [String]) -> [Any] {
        var jsonData = [Any]()
        for sortedJSON in value {
            jsonData.append(sortJSONData(sortedJSON))
        }
        return jsonData
    }
    
    private func sortJSONData(_ value: String) -> Any {
        if let boolType = Bool(value) {
            return boolType
        } else if let intType = Int(value) {
            return intType
        }
        return hasStringType(value)
    }
    
    private func hasStringType(_ value: String) -> String{
        var pureString = value
        pureString.removeFirst()
        pureString.removeLast()
        return pureString
    }

}

