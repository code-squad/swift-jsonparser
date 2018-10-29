//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by 윤지영 on 29/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {

    static func isValid(_ jsonString: String, for pattern: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return false }
        let fullRange = NSRange(jsonString.startIndex..., in: jsonString)
        let matchRange = regex.rangeOfFirstMatch(in: jsonString, options: [], range: fullRange)
        guard fullRange == matchRange else { return false }
        return true
    }

}
