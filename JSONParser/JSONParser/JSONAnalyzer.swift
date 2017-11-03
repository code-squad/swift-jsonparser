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
            let contentsOutOfArray = jsonString.stripAwayParenthesis()
            guard let datas = convertStringToDatas(contentsOutOfArray) else {
                throw FormatError.invalidDataType
            }
            return JSONData(array: datas)
        }
        if GrammarChecker.isJSONObject(jsonString) {
            // json Object 일 때
            let contentsOutOfJSONObject = jsonString.stripAwayParenthesis().trimmingWhiteSpaceAfterSplit(with: ",")
            guard let jsonObject = convertStringsToJSONObject(contentsOutOfJSONObject) else {
                throw FormatError.invalidDataType
            }
            return JSONData(array: [jsonObject])
        }
        if GrammarChecker.isJSONObjectArray(jsonString) {
            // json Object 타입 배열 일 때
            let contentsOutOfArray = jsonString.stripAwayParenthesis()
            guard let jsonObjects = convertStringToJSONObjects(contentsOutOfArray) else {
                throw FormatError.invalidDataType
            }
            return JSONData(array: jsonObjects)
        }
        throw FormatError.notFormatted
    }
    
    // Dictionay 형태의 스트링 배열을 JSON Object로 변경
    private static func convertStringsToJSONObject(_ dictionaryStrings: [String]) -> JSONObject? {
        var dictionaryForResult = [String : Value]()
        for dictionaryString in dictionaryStrings {
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
        var remainObjectString = objectsString
        var jsonObjectsForResult = [JSONObject]()
        while (true) {
            guard let indexOfOpenParenthesis = remainObjectString.index(of: "{"),
                let indexOfCloseParenthesis = remainObjectString.index(of: "}") else { break }
            
            let sliceStringArray = remainObjectString[remainObjectString
                .index(after: indexOfOpenParenthesis)...remainObjectString
                    .index(before: indexOfCloseParenthesis)]
            let sliceDictionaryStrings = sliceStringArray.trimmingWhiteSpaceAfterSplit(with: ",")
            
            guard let jsonObject = convertStringsToJSONObject(sliceDictionaryStrings) else {
                return nil
            }
            jsonObjectsForResult.append(jsonObject)
            guard remainObjectString.index(of: "}") != remainObjectString.index(before: remainObjectString.endIndex) else {
                break
            }
            remainObjectString = String(remainObjectString[remainObjectString
                .index(after:indexOfCloseParenthesis)...remainObjectString
                    .index(before: remainObjectString.endIndex)])
        }
        return jsonObjectsForResult
    }
    
    private static func convertStringToDatas(_ datasString: String) -> [Value]? {
        var valuesForResult = [Value]()
        let splitStrings = datasString.trimmingWhiteSpaceAfterSplit(with: ",")
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
        case notFormatted = "데이터 형식이 올바르지 않습니다."
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

