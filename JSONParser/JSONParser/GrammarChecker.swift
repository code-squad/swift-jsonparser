//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by yangpc on 2017. 11. 2..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    static let nestedObject = "\\{\\s*((((\"[^\"]+\")\\s*\\:\\s*(\\d+|false|true|\"[^\"]*\"|\\{\\s*(((\"[^\"]+\")\\s*\\:\\s*(\\d+|false|true|\"[^\"]*\"))\\,\\s*)*((\"[^\"]+\")\\s*\\:\\s*(\\d+|false|true|\"[^\"]*\"))*\\s*\\}|\\[\\s*((\\d*|true|false|\"[^\"]*\")*\\,\\s*)*(\\d+|false|true|\"[^\"]*\")\\s*\\]))\\,\\s*)*((\"[^\"]+\")\\s*\\:\\s*(\\d+|false|true|\"[^\"]*\"|\\{\\s*(((\"[^\"]+\")\\s*\\:\\s*(\\d+|false|true|\"[^\"]*\"))\\,\\s*)*((\"[^\"]+\")\\s*\\:\\s*(\\d+|false|true|\"[^\"]*\"))*\\s*\\}|\\[\\s*((\\d*|true|false|\"[^\"]*\")*\\,\\s*)*(\\d+|false|true|\"[^\"]*\")\\s*\\])*)*)*\\s*\\}"
    static let nestedArray = "\\[\\s*((\\d*|true|false|\"[^\"]*\"|\\[\\s*((\\d*|true|false|\"[^\"]*\")*\\,\\s*)*(\\d+|false|true|\"[^\"]*\")\\s*\\]|\\{\\s*(((\"[^\"]+\")\\s*\\:\\s*([0-9]+|false|true|\"[^\"]*\"))\\,\\s*)*((\"[^\"]+\")\\s*\\:\\s*(\\d*|false|true|\"[^\"]\"))*\\s*\\})*\\,\\s*)*(\\d+|false|true|\"[^\"]*\"|\\[\\s*((\\d*|true|false|\"[^\"]*\")*\\,\\s*)*(\\d+|false|true|\"[^\"]*\")\\s*\\]|\\{\\s*(((\"[^\"]+\")\\s*\\:\\s*([0-9]+|false|true|\"[^\"]*\"))\\,\\s*)*((\"[^\"]+\")\\s*\\:\\s*([0-9]+|false|true|\"[^\"]*\"))*\\s*\\})\\s*\\]"
    static let dictionary = "(\"[^\"]+\")\\s*\\:\\s*(\\d+|false|true|\"[^\"]*\"|\\{\\s*(((\"[^\"]+\")\\s*\\:\\s*(\\d+|false|true|\"[^\"]*\"))\\,\\s*)*((\"[^\"]+\")\\s*\\:\\s*(\\d+|false|true|\"[^\"]*\"))*\\s*\\}|\\[\\s*((\\d*|true|false|\"[^\"]*\")*\\,\\s*)*(\\d+|false|true|\"[^\"]*\")\\s*\\])"
    static let value = "\\d+|false|true|\"[^\"]*\"|\\[\\s*((\\d*|true|false|\"[^\"]*\")*\\,\\s*)*(\\d+|false|true|\"[^\"]*\")\\s*\\]|\\{\\s*(((\"[^\"]+\")\\s*\\:\\s*([0-9]+|false|true|\"[^\"]*\"))\\,\\s*)*((\"[^\"]+\")\\s*\\:\\s*([0-9]+|false|true|\"[^\"]*\"))*\\s*\\}"
    static let innerArray = "\\[\\s*((\\d*|true|false|\"[^\"]*\")*\\,\\s*)*(\\d+|false|true|\"[^\"]*\")\\s*\\]"
    static let innerValue = "\\d+|false|true|\"[^\"]*\""

    static func isValid(pattern: String) -> (String) -> Bool {
        return { (jsonString: String) -> Bool in
            guard let results = jsonString.findMatchedStrings(with: pattern) else {
                return false
            }
            return results == [jsonString]
        }
    }
}

extension GrammarChecker {
    enum FormatError: String, Error {
        case notFormatted = "지원하지 않는 형식을 포함하고 있습니다."
        case invalidDataType = "지원하지 않는 데이터 타입 입니다."
    }
}

extension String {
    
    func findMatchedStrings(with regularExpression: String) -> [String]? {
        do {
            // 파라미터로 받은 패턴으로 RegExp 객체 생성.
            let regex = try NSRegularExpression(pattern: regularExpression)
            // 현재 문자열(self)에서 패턴에 매칭되는 결과 반환. (NSTextCheckingResult 배열타입)
            let range = NSMakeRange(0, self.characters.count)
            let nsTextResults = regex.matches(in: self, options: [], range: range)
            let results = nsTextResults.map{ String(self[Range($0.range, in: self)!]) }
            return results
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
