//
//  JSONArrayParser.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 15..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation
// JSONParser for Array
extension JSONParser {
    func makeArrayJSONData(_ value: String) throws -> JSONData {
        var resultOfParser = [JSONType]()
        let removedBracket = supportingJSON.processBeforeMakingJSON(value)
        var rawJSON = removedBracket.trimmingCharacters(in: .whitespacesAndNewlines)
        var checkEndElement = true
        while checkEndElement {
            if rawJSON.hasPrefix("{") {
                let rawObjects = try makeObjectsInArray(rawJSON)
                resultOfParser.append(rawObjects.object)
                rawJSON.removeSubrange(rawJSON.startIndex...rawObjects.elementIdx)
                if rawJSON.hasPrefix(",") {
                    rawJSON.removeSubrange(rawJSON.startIndex..<rawJSON.index(rawJSON.startIndex, offsetBy: 2))
                } else {
                    checkEndElement = false
                }
            } else {
                let rawArrays = try makeJSONInArray(rawJSON)
                resultOfParser.append(rawArrays.object)
                rawJSON.removeSubrange(rawJSON.startIndex..<rawArrays.elementIdx)
                if rawJSON.hasPrefix(",") {
                    rawJSON.removeSubrange(rawJSON.startIndex..<rawJSON.index(rawJSON.startIndex, offsetBy: 2))
                } else {
                    checkEndElement = false
                }
            }
        }
        return JSONData(resultOfParser)
    }
    
    // [ { } ] 처리로직
    private func makeObjectsInArray(_ value: String) throws -> (object: JSONType, elementIdx: String.Index) {
        let rawJSON = value
        var jsonObjects: JSONType
        if rawJSON.hasPrefix("{") {
            let objectAndEndBrace = try makeObjectInArray(rawJSON)
            jsonObjects = JSONType.objectType(objectAndEndBrace.object)
            return (jsonObjects, objectAndEndBrace.endBraceIndex)
        }
        throw ErrorCode.invalidJSONStandard
    }
    
    private func makeObjectInArray(_ value: String) throws -> (object: String, endBraceIndex: String.Index) {
        let rawJSON = value
        let rawObject: String
        guard let endBrace = rawJSON.index(of: "}") else {
            throw ErrorCode.invalidJSONStandard
        }
        rawObject = String(rawJSON.prefix(through: endBrace))
        return (rawObject, endBrace)
    }
    
    // [ , ] 처리로직
    private func makeJSONInArray(_ value: String) throws -> (object: JSONType, elementIdx: String.Index) {
        let rawJSON = value
        var jsonType: JSONType
        if let endOfElementIdx = rawJSON.index(of: ",") {
            let element = String(rawJSON.prefix(through: endOfElementIdx))
            jsonType = supportingJSON.sortJSONData(element)
            return (jsonType, endOfElementIdx)
        }
        throw ErrorCode.invalidJSONStandard
    }
    
}
