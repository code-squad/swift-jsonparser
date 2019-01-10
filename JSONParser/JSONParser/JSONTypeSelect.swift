//
//  JSONTypeSelect.swift
//  JSONParser
//
//  Created by Elena on 04/01/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

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
