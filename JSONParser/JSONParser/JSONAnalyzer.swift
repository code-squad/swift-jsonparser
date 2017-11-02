//
//  JSONAnalyzer.swift
//  JSONParser
//
//  Created by yangpc on 2017. 10. 30..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

// JSON String -> JSONObject

struct JSONAnalyzer {
    
    static func makeObject(with jsonString: String) throws -> JSONData {
        
        let parenthesis = (jsonString.head, jsonString.tail)
        
        switch parenthesis {
        case ("[", "]"):
            // Array 일 때
            let contentsOutOfArray = jsonString.stripAwayParenthesis()
            if contentsOutOfArray.isObject {
                // Array에 담긴 데이터가 json Object일 때
                guard let jsonObjects = convertStringToJSONObjects(contentsOutOfArray) else {
                    throw FormatError.invalidDataType
                }
                return JSONData(array: jsonObjects)
            }
            else {
                // Array에 담긴 데이터가 Number, Bool, String (datas) 일 때
                guard let datas = convertStringToDatas(contentsOutOfArray) else {
                    throw FormatError.invalidDataType
                }
                return JSONData(array: datas)
            }
        case ("{", "}"):
            // json Object 일 때
            let contentsOutOfObject = jsonString.stripAwayParenthesis().splitNoEmpty(with: ",")
            guard let jsonObject = convertStringsToJSONObject(contentsOutOfObject) else {
                throw FormatError.invalidDataType
            }
            return JSONData(object: jsonObject)
        default: break
        }
        throw FormatError.notFormatted
    }
    
    // Dictionay 형태의 스트링 배열을 JSON Object로 변경
    private static func convertStringsToJSONObject(_ dictionaryStrings: [String]) -> JSONObject? {
        var contentsDictionary = [String : value]()
        for dictionary in dictionaryStrings {
            let contentsOfdictionary = dictionary.split(separator: ":").map{
                $0.trimmingCharacters(in: .whitespaces)
            }
            let keyString = contentsOfdictionary[0]
            let valueString = contentsOfdictionary[1]
            guard let key = keyString.convertStringToKey else { return nil }
            guard let value = valueString.convertStringToValue else { return nil }
            contentsDictionary[key] = value
        }
        return JSONObject(dictionary: contentsDictionary)
    }
    
    // "{"key":value...}, {"key":value...}, ..." 형태의 스트링을 json object 배열로 변경
    private static func convertStringToJSONObjects(_ objectsString: String) -> [JSONObject]? {
        var remainObjectString = objectsString
        var resultDictionary = [JSONObject]()
        while (true) {
            guard let indexOfOpenParenthesis = remainObjectString.index(of: "{"),
                let indexOfCloseParenthesis = remainObjectString.index(of: "}") else { break }
            
            let sliceStringArray = remainObjectString[remainObjectString
                .index(after: indexOfOpenParenthesis)...remainObjectString
                    .index(before: indexOfCloseParenthesis)]
            let sliceDictionaryStrings = sliceStringArray.splitNoEmpty(with: ",")
            
            guard let jsonObject = convertStringsToJSONObject(sliceDictionaryStrings) else {
                return nil
            }
            resultDictionary.append(jsonObject)
            guard remainObjectString.index(of: "}") != remainObjectString.index(before: remainObjectString.endIndex) else {
                break
            }
            remainObjectString = String(remainObjectString[remainObjectString
                .index(after:indexOfCloseParenthesis)...remainObjectString
                    .index(before: remainObjectString.endIndex)])
        }
        return resultDictionary
    }
    
    private static func convertStringToDatas(_ datasString: String) -> [Any]? {
        var resultArray = [value]()
        let splitStrings = datasString.splitNoEmpty(with: ",")
        for contents in splitStrings {
            guard let value = contents.convertStringToValue else {
                return nil
            }
            resultArray.append(value)
        }
        return resultArray
    }
    
}

extension JSONAnalyzer {
    enum FormatError: String, Error {
        case notFormatted = "데이터 형식이 올바르지 않습니다."
        case invalidDataType = "지원하지 않는 데이터 타입 입니다."
    }
    
}

extension Substring {
    func splitNoEmpty(with separator: Character) -> [String] {
        return self.split(separator: separator).map{$0.trimmingCharacters(in: .whitespaces)}
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
    
    func splitNoEmpty(with separator: Character) -> [String] {
        return self.split(separator: separator).map{$0.trimmingCharacters(in: .whitespaces)}
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
    
    var convertStringToValue: value? {
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

