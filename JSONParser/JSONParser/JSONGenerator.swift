//
//  JSONGenerator.swift
//  JSONParser
//
//  Created by 윤지영 on 18/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONGenerator {
    private static let stringArray = { (jsonString: String) -> [String] in return jsonString.removeWhiteSpaces().trimSquareBrackets().splitByComma() }
    
    private static func extractStringArray(from jsonString: String) -> [String]? {
        guard jsonString.hasSideSquareBrackets() else { return nil }
        return stringArray(jsonString)
    }
    
    private static func typeCast(from string: String) -> Any? {
        guard string.hasDoubleQuotation() == false else { return string.trimDoubleQuotation() }
        guard Int(string) == nil else { return Int(string) }
        guard Bool(string) == nil else { return Bool(string) }
        return nil
    }
    
    static func makeJSONArray(from jsonString: String) -> [Any?]? {
        guard let stringArray = extractStringArray(from: jsonString) else { return nil }
        var anyArray = [Any?]()
        for string in stringArray {
            anyArray.append(typeCast(from: string))
        }
        return anyArray
    }
}
