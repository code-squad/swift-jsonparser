//
//  JSONGenerator.swift
//  JSONParser
//
//  Created by 윤지영 on 18/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONGenerator {
    static let stringArray = { (jsonString: String) -> [String] in return jsonString.removeWhiteSpaces().trimSquareBrackets().splitByComma() }
}
