//
//  Parser.swift
//  JSONParser
//
//  Created by Elena on 20/12/2018.
//  Copyright © 2018 elena. All rights reserved.
//

import Foundation

struct Parser {
    //커링 방법을 사용해서 문자열에 괄호 패턴이 있는지 확인하는 메소드
    private static func regexTest(pattern: String) -> (String) -> Bool {
        let expression: NSRegularExpression? = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return { (input: String) -> Bool in
            guard let expression = expression else { return false }
            let inputRange = NSMakeRange(0, input.characters.count)
            let matches = expression.matches(in: input, options: [], range: inputRange)
            return matches.count > 0
        }
    }
    // 객체일때 Dictionary
    private static func splitByKeyValue(from data: String) -> (key: String, value: JSONType?) {
        let grammarChecker = regexTest(pattern: GrammarChecker.keyValue)(data)
        guard grammarChecker else { return (data,nil) }
        let objectKeyValue = data.splitByColon()
        let key: String = objectKeyValue[0]
        let value = JSONTypeSelect.selectJSONData(objectKeyValue[1])
        return (key, value)
    }
    
    private static func makeJSONObject(from data: String) -> [String: JSONType]? {
        let grammarChecker = regexTest(pattern: GrammarChecker.jsonObject)(data)
        guard grammarChecker else { return nil }
        var jsonObject = [String: JSONType]()
        let keyValues = data.splitByComma()
        for keyValue in keyValues {
            let keyValueSplit = splitByKeyValue(from: keyValue)
            if keyValueSplit.value == nil { return nil}
            guard let value: JSONType = keyValueSplit.value else { continue }
            jsonObject[keyValueSplit.key] = value
        }
        return jsonObject
    }
    
    private static func makeJSONArray(from data: String) -> [JSONType]? {
        let grammarChecker = regexTest(pattern: GrammarChecker.jsonArray)(data)
        guard grammarChecker else { return nil }
        var jsonArray = [JSONType]()
        let data = data.removeBothFirstAndLast()
        let hasBracketIn = regexTest(pattern: GrammarChecker.leftBracket)
        let result = hasBracketIn(data)
        guard result else { return nil }
        let value = data.splitByBracket()
        for index in 0..<value.count {
            guard let parserData = JSONTypeSelect.selectSimpleLine(value[index]) else {
                return nil
            }
            jsonArray.append(parserData)
        }
        return jsonArray
    }
    static func divideData(_ data: String) -> JSONDataForm? {
        guard isDivideData(from: data) else { return nil }
        
        if data.hasPrefix("[") {
            guard let jsonArray = makeJSONArray(from: data) else { return nil }
            return ParserArray.init(jsonArray)
        }
        if data.hasPrefix("{") {
            guard let jsonObject = makeJSONObject(from: data) else { return nil }
            return ParserObject.init(jsonObject)
        }
        return nil
    }
    // 처음과 끝이 bracket 있는지 체크
    static func isDivideData(from data: String) -> Bool {
        if data.hasPrefix("{"), data.hasSuffix("}") {
            return true
        }
        else if data.hasPrefix("["),data.hasSuffix("]")  {
            return true
        }
        return false
    }
    
}
