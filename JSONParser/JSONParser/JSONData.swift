//
//  JSONData.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONData {
    enum Number {
        case UInt
        case Int
        case Float
        case Double
    }
    var string: [String]?
    var number: [Number]?
    var bool: [Bool]?
}

extension JSONData {
    init?(parsedData: [Any]) {
        for each in parsedData {
            switch each {
            case is Number: self.number?.append(each as! Number)
            case is String: self.string?.append(each as! String)
            case is Bool: self.bool?.append(each as! Bool)
            default: break
            }
        }
    }
    
    static func parse(from rawData: String) -> [Any] {
        return []
    }
}

extension String {
    func split(by rxPattern: String) throws -> [String] {
        do {
            let expression = try NSRegularExpression(pattern: rxPattern)
            let matchedRange = expression.matches(in: self, options: .init(rawValue: 0), range: NSRange.init(self.startIndex..., in: self))
            return matchedRange.map({
                return String(self[Range($0.range, in: self)!])
            })
        } catch {
            throw error
        }
    }
}
