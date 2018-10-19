//
//  File.swift
//  JSONParser
//
//  Created by 윤지영 on 18/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol TypeInspector {
    static func countType(stringArray: [String]) -> Int
}

struct StringInspector: TypeInspector {
    private static let doubleQuotation: Character = "\""
    private static func hasDoubleQuotation(_ text: String) -> Bool {
        return (text.count > 1 && text.first == doubleQuotation && text.last == doubleQuotation)
    }
    static func countType(stringArray: [String]) -> Int {
        let typeArray = stringArray.map({ hasDoubleQuotation($0) ? $0.trimDoubleQuotation() : nil })
        return typeArray.compactMap({ $0 }).count
    }
}

struct DoubleInspector: TypeInspector {
    static func countType(stringArray: [String]) -> Int {
        return stringArray.compactMap({ Double($0) }).count
    }
}

struct BooleanInspector: TypeInspector {
    private static let boolExpression = Set(["A", "B", "C", "D"])
    private static func isBoolExpression(_ text: String) -> Bool? {
        return boolExpression.contains(text) ? true : nil
    }
    static func countType(stringArray: [String]) -> Int {
        return stringArray.compactMap({ Bool($0) }).count
    }
}
