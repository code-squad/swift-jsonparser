//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by yangpc on 2017. 11. 2..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    static let nestedJSONObjectRegularExpression = "\\{ (((\"\\w+\") \\: (\\d+|false|true|\"(\\w+\\s)*\\w+\"|\\{ (((\"\\w+\") \\: (\\d+|false|true|\"(\\w+\\s)*\\w+\"))\\, )*((\"\\w+\") \\: (\\d+|false|true|\"(\\w+\\s)*\\w+\"))* \\}|\\[ ((\\d*|true|false|\"\\w*\")*\\, )*(\\d+|false|true|\"\\w+\") \\]))\\, )*((\"\\w+\") \\: (\\d+|false|true|\"(\\w+\\s)*\\w+\"|\\{ (((\"\\w+\") \\: (\\d+|false|true|\"(\\w+\\s)*\\w+\"))\\, )*((\"\\w+\") \\: (\\d+|false|true|\"(\\w+\\s)*\\w+\"))* \\}|\\[ ((\\d*|true|false|\"\\w*\")*\\, )*(\\d+|false|true|\"\\w*\") \\]))* \\}"
    static let nestedArrayRegularExpression = "\\[ ((\\d*|true|false|\"\\w*\"|\\[ ((\\d*|true|false|\"\\w*\")*\\, )*(\\d+|false|true|\"\\w+\") \\]|\\{ (((\"[a-zA-Z]+\") \\: ([0-9]+|false|true|\"([a-zA-Z]+\\s)*[a-zA-Z]+\"))\\, )*((\"[a-zA-Z]+\") \\: (\\d*|false|true|\"([a-zA-Z]*\\s)*[a-zA-Z]*\"))* \\})*\\, )*(\\d+|false|true|\"\\w+\"|\\[ ((\\d*|true|false|\"\\w*\")*\\, )*(\\d+|false|true|\"\\w+\") \\]|\\{ (((\"[a-zA-Z]+\") \\: ([0-9]+|false|true|\"([a-zA-Z]+\\s)*[a-zA-Z]+\"))\\, )*((\"[a-zA-Z]+\") \\: ([0-9]+|false|true|\"([a-zA-Z]+\\s)*[a-zA-Z]+\"))* \\}) \\]"
    static let dictionaryRegularExpression = "((\"\\w+\") \\: (\\d+|false|true|\"(\\w+\\s)*\\w+\"|\\{ (((\"\\w+\") \\: (\\d+|false|true|\"(\\w+\\s)*\\w+\"))\\, )*((\"\\w+\") \\: (\\d+|false|true|\"(\\w+\\s)*\\w+\"))* \\}|\\[ ((\\d*|true|false|\"\\w*\")*\\, )*(\\d+|false|true|\"\\w+\") \\]))+"
    static let valueRegularExpression = "\\d+|false|true|\"\\w+\"|\\[ ((\\d*|true|false|\"\\w*\")*\\, )*(\\d+|false|true|\"\\w+\") \\]|\\{ (((\"[a-zA-Z]+\") \\: ([0-9]+|false|true|\"([a-zA-Z]+\\s)*[a-zA-Z]+\"))\\, )*((\"[a-zA-Z]+\") \\: ([0-9]+|false|true|\"([a-zA-Z]+\\s)*[a-zA-Z]+\"))* \\}"
    static let innerArrayRegularExpression = "\\[ ((\\d*|true|false|\"\\w*\")*\\, )*(\\d+|false|true|\"\\w+\") \\]"
    static let innerValueRegularExpression = "\\d+|false|true|\"\\w+\""
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
