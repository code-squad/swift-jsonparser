//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by yangpc on 2017. 11. 2..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    static let nestedJSONObjectRegularExpression = "\\{\\s*((((\"[^\"]+\")\\s*\\:\\s*(\\d+|false|true|\"[^\"]*\"|\\{\\s*(((\"[^\"]+\")\\s*\\:\\s*(\\d+|false|true|\"[^\"]*\"))\\,\\s*)*((\"[^\"]+\")\\s*\\:\\s*(\\d+|false|true|\"[^\"]*\"))*\\s*\\}|\\[\\s*((\\d*|true|false|\"[^\"]*\")*\\,\\s*)*(\\d+|false|true|\"[^\"]*\")\\s*\\]))\\,\\s*)*((\"[^\"]+\")\\s*\\:\\s*(\\d+|false|true|\"[^\"]*\"|\\{\\s*(((\"[^\"]+\")\\s*\\:\\s*(\\d+|false|true|\"[^\"]*\"))\\,\\s*)*((\"[^\"]+\")\\s*\\:\\s*(\\d+|false|true|\"[^\"]*\"))*\\s*\\}|\\[\\s*((\\d*|true|false|\"[^\"]*\")*\\,\\s*)*(\\d+|false|true|\"[^\"]*\")\\s*\\])*)*)*\\s*\\}"
    static let nestedArrayRegularExpression = "\\[\\s*((\\d*|true|false|\"[^\"]*\"|\\[\\s*((\\d*|true|false|\"[^\"]*\")*\\,\\s*)*(\\d+|false|true|\"[^\"]*\")\\s*\\]|\\{\\s*(((\"[^\"]+\")\\s*\\:\\s*([0-9]+|false|true|\"[^\"]*\"))\\,\\s*)*((\"[^\"]+\")\\s*\\:\\s*(\\d*|false|true|\"[^\"]\"))*\\s*\\})*\\,\\s*)*(\\d+|false|true|\"[^\"]*\"|\\[\\s*((\\d*|true|false|\"[^\"]*\")*\\,\\s*)*(\\d+|false|true|\"[^\"]*\")\\s*\\]|\\{\\s*(((\"[^\"]+\")\\s*\\:\\s*([0-9]+|false|true|\"[^\"]*\"))\\,\\s*)*((\"[^\"]+\")\\s*\\:\\s*([0-9]+|false|true|\"[^\"]*\"))*\\s*\\})\\s*\\]"
    static let dictionaryRegularExpression = "(\"[^\"]+\")\\s*\\:\\s*(\\d+|false|true|\"[^\"]*\"|\\{\\s*(((\"[^\"]+\")\\s*\\:\\s*(\\d+|false|true|\"[^\"]*\"))\\,\\s*)*((\"[^\"]+\")\\s*\\:\\s*(\\d+|false|true|\"[^\"]*\"))*\\s*\\}|\\[\\s*((\\d*|true|false|\"[^\"]*\")*\\,\\s*)*(\\d+|false|true|\"[^\"]*\")\\s*\\])"
    static let valueRegularExpression = "\\d+|false|true|\"[^\"]*\"|\\[\\s*((\\d*|true|false|\"[^\"]*\")*\\,\\s*)*(\\d+|false|true|\"[^\"]*\")\\s*\\]|\\{\\s*(((\"[^\"]+\")\\s*\\:\\s*([0-9]+|false|true|\"[^\"]*\"))\\,\\s*)*((\"[^\"]+\")\\s*\\:\\s*([0-9]+|false|true|\"[^\"]*\"))*\\s*\\}"
    static let innerArrayRegularExpression = "\\[\\s*((\\d*|true|false|\"[^\"]*\")*\\,\\s*)*(\\d+|false|true|\"[^\"]*\")\\s*\\]"
    static let innerValueRegularExpression = "\\d+|false|true|\"[^\"]*\""

    static func isNestedJSONArray(_ jsonString: String) -> Bool {
        return jsonString.isValidAllString(with: nestedArrayRegularExpression)
    }
    
    static func isNestedJSONObject(_ jsonString: String) -> Bool {
        return jsonString.isValidAllString(with: nestedJSONObjectRegularExpression)
    }
    
    static func isInnerArray(_ jsonString: String) -> Bool {
        return jsonString.isValidAllString(with: innerArrayRegularExpression)
    }
}

extension GrammarChecker {
    enum FormatError: String, Error {
        case notFormatted = "지원하지 않는 형식을 포함하고 있습니다."
        case invalidDataType = "지원하지 않는 데이터 타입 입니다."
    }
}

extension String {
    
    func isValidAllString(with regularExpression: String) -> Bool {
        guard let results = findMatchedStrings(with: regularExpression) else {
            return false
        }
        return results == [self]
    }
    
    func findMatchedStrings(with regularExpression: String) -> [String]? {
        do {
            // 파라미터로 받은 패턴으로 RegExp 객체 생성.
            let regex = try NSRegularExpression(pattern: regularExpression)
            // 현재 문자열(self)에서 패턴에 매칭되는 결과 반환. (NSTextCheckingResult 배열타입)
            let nsTextResults = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
            let results = nsTextResults.map{String(self[Range($0.range, in: self)!])}
            return results
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
