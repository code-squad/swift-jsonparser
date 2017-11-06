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
        if GrammarChecker.isNestedJSONObject(jsonString) {
            // nested json Object 일 때
            guard let jsonObject = convertStringToJSONObject(jsonString) else {
                throw GrammarChecker.FormatError.invalidDataType
            }
            return JSONData(array: [jsonObject])
        }
        if GrammarChecker.isNestedJSONArray(jsonString) {
            // nested json 배열 일 때
            guard let jsonObjectArray = convertStringToJSONOArray(jsonString) else {
                throw GrammarChecker.FormatError.invalidDataType
            }
            return JSONData(array: jsonObjectArray)
        }
        throw GrammarChecker.FormatError.notFormatted
    }

    // Dictionay ({"key":value...})형태의 스트링을 JSON Object로 변경
    fileprivate static func convertStringToJSONObject(_ objectsString: String) -> JSONObject? {
        var dictionaryForResult = [String : Value]()
        guard let splitJSONObjectIntoDictionary = objectsString.findMatchedStrings(with: GrammarChecker.dictionaryRegularExpression) else { return nil }
        for dictionaryString in splitJSONObjectIntoDictionary {
            let splitDictionaryStringIntoKeyAndValue = dictionaryString.split(separator: ":").map{
                $0.trimmingCharacters(in: .whitespaces)
            }
            let keyString = splitDictionaryStringIntoKeyAndValue[0]
            let valueString = splitDictionaryStringIntoKeyAndValue[1]
            guard let key = keyString.convertStringToKey else { return nil }
            if GrammarChecker.isInnerArray(valueString) {
                guard let value = convertStringToDatas(valueString) else { return nil }
                dictionaryForResult[key] = value
            } else {
                guard let value = valueString.convertStringToValue else { return nil }
                dictionaryForResult[key] = value
            }
        }
        return JSONObject(dictionary: dictionaryForResult)
    }

    // "{"key":value...}, {"key":value...}, ..." 형태의 스트링을 json object 배열로 변경
    private static func convertStringToJSONOArray(_ objectsString: String) -> [Value]? {
        var jsonObjectsForResult = [Value]()
        guard let splitIntoJSONObjects = objectsString
            .findMatchedStrings(with: GrammarChecker.valueRegularExpression) else {
                return nil
        }
        for jsonObjectFormatString in splitIntoJSONObjects {
            if GrammarChecker.isInnerArray(jsonObjectFormatString) {
                guard let value = convertStringToDatas(jsonObjectFormatString) else { return nil }
                jsonObjectsForResult.append(value)
            } else {
                guard let value = jsonObjectFormatString.convertStringToValue else { return nil }
                jsonObjectsForResult.append(value)
            }
        }
        return jsonObjectsForResult
    }

    fileprivate static func convertStringToDatas(_ datasString: String) -> [Value]? {
        var valuesForResult = [Value]()
        guard let splitStrings = datasString
            .findMatchedStrings(with: GrammarChecker.innerValueRegularExpression) else {
                return nil
        }
        for contents in splitStrings {
            guard let value = contents.convertStringToValue else {
                return nil
            }
            valuesForResult.append(value)
        }
        return valuesForResult
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
            }
            if let valueBool = Bool(self) {
                return valueBool
            }
            if let valueInt = Int(self) {
                return valueInt
            }
            if self.hasParenthesis(head: "{", tail: "}") {
                let valueObject = JSONAnalyzer.convertStringToJSONObject(self)
                return valueObject ?? " "
            }
            return nil
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

