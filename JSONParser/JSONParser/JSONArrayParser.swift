//
//  JSONArrayParser.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 15..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation
// JSONParser for Array
typealias JSONTypeAndIdx = (object: JSONType, elementIdx: String.Index)
extension JSONParser {
    func makeArrayJSONData(_ value: String) throws -> JSONData {
        var resultOfParser = [JSONType]()
        let removedBracket = supportingJSON.processBeforeMakingJSON(value)
        var rawJSON = removedBracket.trimmingCharacters(in: .whitespacesAndNewlines)
        var checkLastElement = true
        while checkLastElement {
            if rawJSON.hasPrefix("{") {
                let rawObjects = try makeObjectsInArray(rawJSON)
                resultOfParser.append(rawObjects.object)
                rawJSON = adjustRawJSON(separatingIdx: rawObjects.elementIdx, rawJSON)
            } else {
                let rawArrays = try makeJSONInArray(rawJSON)
                resultOfParser.append(rawArrays.object)
                rawJSON = adjustRawJSON(separatingIdx: rawArrays.elementIdx, rawJSON)
            }
            if rawJSON.isEmpty { checkLastElement = false }
        }
        return JSONData(resultOfParser)
    }
    
    private func adjustRawJSON(separatingIdx: String.Index, _ rawJSON: String) -> String {
        var preRemoveJSON = rawJSON
        if preRemoveJSON.contains(",") {
            preRemoveJSON.removeSubrange(rawJSON.startIndex...separatingIdx)
            if !preRemoveJSON.isEmpty { preRemoveJSON.removeSubrange(preRemoveJSON.startIndex..<preRemoveJSON.index(preRemoveJSON.startIndex, offsetBy: 2)) }
        } else {
            preRemoveJSON.removeAll()
        }
        return preRemoveJSON
    }
    
    // [ { } ] 처리로직
    private func makeObjectsInArray(_ value: String) throws -> JSONTypeAndIdx {
        let rawJSON = value
        var jsonObjects: JSONType
        guard let endBrace = rawJSON.index(of: "}") else {
            throw ErrorCode.invalidJSONStandard
        }
        let rawObject = String(rawJSON.prefix(through: endBrace))
        jsonObjects = JSONType.objectType(rawObject)
        return (jsonObjects, endBrace)
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
    private func makeJSONInArray(_ value: String) throws -> JSONTypeAndIdx {
        let rawJSON = value
        var jsonType: JSONType
        if let endOfElementIdx = rawJSON.index(of: ",") {
            var element = String(rawJSON.prefix(through: endOfElementIdx))
            element.removeLast()
            jsonType = supportingJSON.sortJSONData(element)
            return (jsonType, rawJSON.index(before: endOfElementIdx))
        } else {
            let element = String(rawJSON.prefix(through: rawJSON.index(before: rawJSON.endIndex)))
            jsonType = supportingJSON.sortJSONData(element)
            return (jsonType, rawJSON.endIndex)
        }
    }
}
