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

    func check(_ value: String?) throws -> String {
        guard let safeValue = value else {
            throw ErrorCode.invalidInputString
        }
        let grammarChecker = GrammarChecker()
        if safeValue.hasPrefix("[") {
            let validValue = try grammarChecker.checkArray(inString: safeValue)
            return validValue
        } else if safeValue.hasPrefix("{"){
            let validValue = try grammarChecker.checkObject(inString: safeValue)
            return validValue
        } else {
            throw ErrorCode.invalidJSONStandard
        }
    }
    
    func makeJSONData(_ value: String) throws -> JSONData {
        if value.hasPrefix("[") {
            let arrayJSON = try makeArrayJSONData(value)
            return arrayJSON
        } else {
            let objectJSON = makeObjectJSONData(value)
            return objectJSON
        }
    }
    
}

// JSONParser for Object
extension JSONParser {
    func makeObjectJSONData(_ rawJSON: String) -> JSONData {
        var objectTypeJSON = [String:JSONType]()
        let removedBrace = processBeforeMakingJSON(rawJSON)
        let separateJSON = removedBrace.components(separatedBy: ",")
        for objectComponents in separateJSON {
            let separateObject = objectComponents.components(separatedBy: ":")
            let key = hasStringType(separateObject[0].trimmingCharacters(in: .whitespacesAndNewlines))
            let objectValue = separateObject[1].trimmingCharacters(in: .whitespacesAndNewlines)
            objectTypeJSON[key] = sortJSONData(objectValue)
        }
        return JSONData(objectTypeJSON)
    }
    
}

// JSONParser for Array
typealias JSONTypeAndIdx = (object: JSONType, elementIdx: String.Index)
extension JSONParser {
    func makeArrayJSONData(_ value: String) throws -> JSONData {
        var resultOfParser = [JSONType]()
        let removedBracket = processBeforeMakingJSON(value)
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
    
    private func adjustRawJSON(separatingIdx: String.Index, _ value: String) -> String {
        var rawJSON = value
        if rawJSON.contains(",") {
            rawJSON.removeSubrange(value.startIndex...separatingIdx)
            if !rawJSON.isEmpty { rawJSON.removeSubrange(rawJSON.startIndex..<rawJSON.index(rawJSON.startIndex, offsetBy: 2)) }
        } else {
            rawJSON.removeAll()
        }
        return rawJSON
    }
    
    // [ { } ] processing logic
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
    
    // [ , ] processing logic
    private func makeJSONInArray(_ value: String) throws -> JSONTypeAndIdx {
        let rawJSON = value.trimmingCharacters(in: .whitespacesAndNewlines)
        var jsonType: JSONType
        if let endOfElementIdx = rawJSON.index(of: ",") {
            var element = String(rawJSON.prefix(through: endOfElementIdx))
            element.removeLast()
            jsonType = sortJSONData(element)
            return (jsonType, rawJSON.index(before: endOfElementIdx))
        } else {
            let element = String(rawJSON.prefix(through: rawJSON.index(before: rawJSON.endIndex)))
            jsonType = sortJSONData(element)
            return (jsonType, rawJSON.endIndex)
        }
    }
    
}
