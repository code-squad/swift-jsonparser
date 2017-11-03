//
//  JSONAnalyzer.swift
//  JSONParser
//
//  Created by yangpc on 2017. 10. 30..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

// JSON String -> JSONData

struct JSONAnalyzer {
    
    static func makeObject(with jsonString: String) throws -> JSONData {

        if GrammarChecker.isDataArray(jsonString) {
            // 기본 타입 배열 일 때
            guard let datas = convertStringToDatas(jsonString) else {
                throw FormatError.invalidDataType
            }
            return JSONData(array: datas)
        }
        if GrammarChecker.isJSONObject(jsonString) {
            // json Object 일 때
            guard let jsonObject = convertStringToJSONObject(jsonString) else {
                throw FormatError.invalidDataType
            }
            return JSONData(array: [jsonObject])
        }
        if GrammarChecker.isJSONObjectArray(jsonString) {
            // json Object 타입 배열 일 때
            guard let jsonObjects = convertStringToJSONObjects(jsonString) else {
                throw FormatError.invalidDataType
            }
            return JSONData(array: jsonObjects)
        }
        throw FormatError.notFormatted
    }
    
    // Dictionay ({"key":value...})형태의 스트링을 JSON Object로 변경
    private static func convertStringToJSONObject(_ objectsString: String) -> JSONObject? {
        var dictionaryForResult = [String : Value]()
        guard let splitJSONObjectIntoDictionary = objectsString.findMatchedStrings(with: GrammarChecker.dictionaryRegularExpression) else { return nil }
        
        for dictionaryString in splitJSONObjectIntoDictionary {
            let splitDictionaryStringIntoKeyAndValue = dictionaryString.split(separator: ":").map{
                $0.trimmingCharacters(in: .whitespaces)
            }
            let keyString = splitDictionaryStringIntoKeyAndValue[0]
            let valueString = splitDictionaryStringIntoKeyAndValue[1]
            guard let key = keyString.convertStringToKey else { return nil }
            guard let value = valueString.convertStringToValue else { return nil }
            dictionaryForResult[key] = value
        }
        return JSONObject(dictionary: dictionaryForResult)
    }
    
    // "{"key":value...}, {"key":value...}, ..." 형태의 스트링을 json object 배열로 변경
    private static func convertStringToJSONObjects(_ objectsString: String) -> [JSONObject]? {
        var jsonObjectsForResult = [JSONObject]()
        guard let splitIntoJSONObjects = objectsString.findMatchedStrings(with: GrammarChecker.jsonObjectRegularExpression) else { return nil }
        for jsonObjectFormatString in splitIntoJSONObjects {
            guard let jsonObject = convertStringToJSONObject(jsonObjectFormatString) else { return nil }
            jsonObjectsForResult.append(jsonObject)
        }
        return jsonObjectsForResult
    }
    
    private static func convertStringToDatas(_ datasString: String) -> [Value]? {
        var valuesForResult = [Value]()
        guard let splitStrings = datasString.findMatchedStrings(with: GrammarChecker.valueRegularExpression) else { return nil }
        for contents in splitStrings {
            guard let value = contents.convertStringToValue else {
                return nil
            }
            valuesForResult.append(value)
        }
        return valuesForResult
    }
    
}

extension JSONAnalyzer {
    enum FormatError: String, Error {
        case notFormatted = "지원하지 않는 형식을 포함하고 있습니다."
        case invalidDataType = "지원하지 않는 데이터 타입 입니다."
    }
    
}

extension StringProtocol {
    func trimmingWhiteSpaceAfterSplit(with separator: Character) -> [String] {
        return self.split(separator: separator).map({ (subSequence: SubSequence) -> String in
            guard let subSequenceToString = subSequence as? NSString else { return " " }
            return subSequenceToString.trimmingCharacters(in: .whitespaces)
        })
    }

}
extension String {
    var head: Character {
        return self[self.startIndex]
    }
    
    var tail: Character {
        return self[self.index(before: self.endIndex)]
    }
    
    var isObject: Bool {
        return self.hasParenthesis(head: "{", tail: "}")
    }
    
    func hasParenthesis(head: Character, tail: Character) -> Bool {
        guard self[self.startIndex] == head
            && self[self.index(before: self.endIndex)] == tail else { return false }
        return true
    }
    func stripAwayParenthesis(withoutSpace: Bool = true) -> String {
        let stripAwayOutLayerString = String(
            self[self.index(after: self.startIndex)..<self.index(before: self.endIndex)])
        if withoutSpace {
            return stripAwayOutLayerString.trimmingCharacters(in: .whitespaces)
        }
        return stripAwayOutLayerString
    }
    
    var convertStringToValue: Value? {
        get {
            if self.hasParenthesis(head: "\"", tail: "\"") {
                let value = self.stripAwayParenthesis()
                return value
            } else if let valueBool = Bool(self) {
                return valueBool
            } else if let valueInt = Int(self) {
                return valueInt
            } else { return nil }
        }
    }
    var convertStringToKey: String? {
        get {
            if self.hasParenthesis(head: "\"", tail: "\"") {
                let value = self.stripAwayParenthesis()
                return value
            } else { return nil }
        }
    }    
}

