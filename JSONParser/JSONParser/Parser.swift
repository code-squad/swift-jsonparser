//
//  Parser.swift
//  JSONParser
//
//  Created by Elena on 20/12/2018.
//  Copyright © 2018 elena. All rights reserved.
//
import Foundation

extension String {
    func removeBothFirstAndLast() -> String {
        return String(self.dropFirst().dropLast())
    }
    func splitByColon() -> [String] {
        return self.split(separator: ":").map({ String($0)})
    }
    func confirmByBigBrackets() -> Bool {
        return self.first == "[" && self.last == "]"
    }
    func confirmByBracket() -> Bool {
        return self.first == "{" && self.last == "}"
    }
}

struct Parser {
    
    private static func splitByKeyValue(from data: String) -> (key: String, value: JSONType?) {
        let objectKeyValue = data.splitByColon().map { $0.trimmingCharacters(in: CharacterSet(charactersIn: " ")) }
        let key: String = objectKeyValue[0]
        let value = selectJSONType(from: objectKeyValue[1])
        return (key, value)
    }
    
    private static func selectJSONType(from string: String) -> JSONType? {
        if string.confirmByBigBrackets() {
            guard let jsonArray = makeJSONArray(from: string) else { return nil }
            return jsonArray
        }
        if string.confirmByBracket() {
            guard let jsonObject = makeJSONObject(from: string) else { return nil }
            return jsonObject
        }
        if string.first == "\"" && string.last == "\"" {
            return string.trimmingCharacters(in: CharacterSet(charactersIn: "\""))
        }
        if let int = Int(string) {
            return int
        }
        if let bool = Bool(string) {
            return bool
        }
        return nil
    }
    
    private static func regexString(pattern: String , _ data: String) ->[String] {
        let string = data.removeBothFirstAndLast()
        guard let expression = try? NSRegularExpression(pattern: pattern, options: []) else { return [] }
        let range = NSRange(string.startIndex..., in: string)
        let matches = expression.matches(in: string, options: [], range: range)
        return matches.map { String(string[Range($0.range, in: string)!]) }
    }
    
    private static func makeJSONObject(from data: String) -> [String: JSONType]? {
        var jsonObject = [String: JSONType]()
        let keyValues = regexString(pattern: GrammarChecker.keyValueInArray , data)
        for keyValue in keyValues {
            let keyValueSplit = splitByKeyValue(from: keyValue)
            guard let value: JSONType = keyValueSplit.value else { continue }
            jsonObject[keyValueSplit.key] = value
        }
        return jsonObject
    }
    private static func makeJSONArray(from data: String) -> [JSONType]? {
        var jsonArray = [JSONType]()
        let jsonValues = regexString(pattern: GrammarChecker.valuesInArray, data)
        for jsonValue in jsonValues {
            guard let keyValueType = selectJSONType(from: jsonValue) else { return nil }
            jsonArray.append(keyValueType)
        }
        return jsonArray
    }
    
    
    static func divideData(_ data: String) -> JSONDataForm? {
        let jsonString = data.trimmingCharacters(in: CharacterSet(charactersIn: " "))
        if GrammarChecker.regexTest(pattern: GrammarChecker.jsonArray)(jsonString) {
            guard let jsonArray = makeJSONArray(from: jsonString) else { return nil }
            return jsonArray
        }
        if GrammarChecker.regexTest(pattern: GrammarChecker.jsonObject)(jsonString) {
            guard let jsonObject = makeJSONObject(from: jsonString) else { return nil }
            return jsonObject
        }
        return nil
    }
    
}
