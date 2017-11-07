//
//  JSONParser.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 7..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    enum JSONPattern: String {
        case number = "((?!\")[0-9]+(?!\"))\\b"
        case string = "\"{1}[a-zA-B가-힣ㄱ-ㅎㅏ-ㅣ0-9]+\"{1}"
        case bool = "true|false"
    }
    
    static func parse(from rawData: String) throws -> JSONData {
        let parsedNumber = try rawData.matches(by: JSONPattern.number.rawValue)
        let parsedString = try rawData.matches(by: JSONPattern.string.rawValue)
        let parsedBool = try rawData.matches(by: JSONPattern.bool.rawValue)
        let numberData = JSONParser.split(rawData, ofRange: parsedNumber) as! [JSONData.Number]
        let stringData = JSONParser.split(rawData, ofRange: parsedString) as! [String]
        let boolData = JSONParser.split(rawData, ofRange: parsedBool) as! [Bool]
        return JSONData(number: numberData, string: stringData, bool: boolData)
    }
    
    static func split(_ inputValue: String, ofRange matchedRange: [NSTextCheckingResult]) -> [Any] {
        let matchedResult: [Any?] = matchedRange.map{
            return convert(inputValue, with: $0)
        }
        return matchedResult.flatMap{ $0 }
    }
    
    static func convert(_ inputValue: String, with nsInfo: NSTextCheckingResult) -> Any? {
        switch nsInfo.regularExpression!.pattern {
        case JSONPattern.number.rawValue:
            guard let number = Int(inputValue[Range(nsInfo.range, in: inputValue)!]) else { return nil }
            return number
        case JSONPattern.string.rawValue:
            let extractedString = inputValue[Range(nsInfo.range, in: inputValue)!]
            let extractedStringWithoutParenthesis = extractedString.replacingOccurrences(of: "\"", with: "")
            return String(extractedStringWithoutParenthesis)
        case JSONPattern.bool.rawValue:
            guard let bool = Bool(String(inputValue[Range(nsInfo.range, in: inputValue)!])) else { return nil }
            return bool
        default:
            return String(inputValue[Range(nsInfo.range, in: inputValue)!])
        }
    }
}

extension String {
    
    func matches(by rxPattern: String) throws -> [NSTextCheckingResult] {
        do {
            let expression = try NSRegularExpression(pattern: rxPattern)
            let matchedRange = expression.matches(in: self, options: .init(rawValue: 0), range: NSRange.init(self.startIndex..., in: self))
            return matchedRange
        } catch {
            throw error
        }
    }

}

