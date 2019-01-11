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



struct JSONTypeSelect {
    
    // JSONData Type을 선택해서 반환
    static func selectJSONData(_ data: String) -> JSONType? {
        var resultData = JSONType.int(0)
        var value = bracket(data)
        value = value.trimmingCharacters(in:.whitespacesAndNewlines)
        if isStringType(value) {
            resultData = JSONType.string(value)
        } else if isBoolType(value) {
            guard let isData = Bool(value) else { return nil }
            resultData = JSONType.bool(isData)
        } else if isNumber(value) && isValidCharacter(value) {
            guard let isData = Int(value) else { return nil }
            resultData = JSONType.int(isData)
        }
        return resultData
    }
    // bracket 체크 , 배열의 경우
    static func selectSimpleLine(_ data: String) -> JSONType? {
        var resultData = JSONType.int(0)
        var value = bracket(data)
        value = value.trimmingCharacters(in:.whitespacesAndNewlines)
        resultData = JSONType.string(data)
        return resultData
    }
    private static func bracket(_ data: String) -> String {
        if data.hasPrefix("[") || data.hasPrefix("{"){
            let noBracketData = data.dropFirst()
            return String(noBracketData)
        }else if data.hasSuffix("]") || data.hasSuffix("}") {
            let noBracketData = data.dropLast()
            return String(noBracketData)
        }
        return data
    }
    
    private static func isNumber (_ popData: String) -> Bool {
        return popData.components(separatedBy: CharacterSet.decimalDigits).count != 0
    }
    private static func isValidCharacter(_ popData: String) -> Bool {
        let validCharacter = CharacterSet.init(charactersIn: "0123456789")
        return (popData.rangeOfCharacter(from: validCharacter.inverted) == nil)
    }
    
    private static func isStringType (_ popData: String) -> Bool {
        return popData.first == "\"" && popData.last == "\""
    }
    
    private static func isBoolType (_ popData: String) -> Bool {
        return popData.contains("true") || popData.contains("false")
    }
}
