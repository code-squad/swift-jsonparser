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
    
    static func extractStringArray(from jsonString: String) -> [String]? {
        guard jsonString.hasSideSquareBrackets() else { return nil }
        return stringArray(jsonString)
    }
}
