//
//  JSONData.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONData {
    typealias Number = Int
    var number: [Number] = []
    var string: [String] = []
    var bool: [Bool] = []
    var count: Int {
        return self.number.count + self.string.count + self.bool.count
    }
}

extension JSONData {
    
    private(set) static var numberPattern = "((?!\")[0-9]+(?!\"))\\b"
    private(set) static var stringPattern = "\"{1}[a-zA-B가-힣ㄱ-ㅎㅏ-ㅣ0-9]+\"{1}"
    private(set) static var boolPattern = "true|false"
    
    init(_ parsedData: [Any]) {
        for data in parsedData {
            switch data {
            case is Number: self.number.append(data as! Number)
            case is String: self.string.append(data as! String)
            case is Bool: self.bool.append(data as! Bool)
            default: break
            }
        }
    }
    
    static func parse(from rawData: String) throws -> [Any] {
        let numberData = try rawData.split(by: numberPattern)
        let stringData = try rawData.split(by: stringPattern)
        let boolData = try rawData.split(by: boolPattern)
        return numberData + stringData + boolData
    }
    
}

extension String {
    
    func split(by rxPattern: String) throws -> [Any] {
        do {
            let expression = try NSRegularExpression(pattern: rxPattern)
            let matchedRange = expression.matches(in: self, options: .init(rawValue: 0), range: NSRange.init(self.startIndex..., in: self))
            let matchedResult: [Any?] = matchedRange.map{
                return convert(with: $0, using: rxPattern)
            }
            return matchedResult.flatMap{ $0 }
        } catch {
            throw error
        }
    }
    
    func convert(with nsInfo: NSTextCheckingResult, using rxPattern: String) -> Any? {
        switch rxPattern {
        case JSONData.numberPattern:
            guard let number = Int(self[Range(nsInfo.range, in: self)!]) else { return nil }
            return number
        case JSONData.stringPattern:
            let extractedString = self[Range(nsInfo.range, in: self)!]
            let extractedStringWithoutParenthesis = extractedString.replacingOccurrences(of: "\"", with: "")
            return String(extractedStringWithoutParenthesis)
        case JSONData.boolPattern:
            guard let bool = Bool(String(self[Range(nsInfo.range, in: self)!])) else { return nil }
            return bool
        default:
            return String(self[Range(nsInfo.range, in: self)!])
        }
    }
    
}
