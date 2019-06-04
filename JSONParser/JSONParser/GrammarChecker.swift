//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by hw on 28/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

extension String {
    func jsonPatternCheck(for regex: String, in inputString: String) -> [String] {
        do {
            if let regex = try? NSRegularExpression(pattern: regex, options: .caseInsensitive){
                let test = regex.matches(in: inputString, options: [], range: NSRange(location:0, length: inputString.count))
                let result : [String] = test.map{ String(inputString[Range($0.range, in: inputString)!])}
                return result
            }
        }
        //if fails
        return []
    }
}
struct GrammarChecker {
    func checkJsonArrayPattern(_ input: String) -> Bool {
        let invalidCharacterSetFilter: String = "^[{1} [\\s]* [a-zA-Z\\d\\s]*  ]$"
        
        return true
    }
    func checkJsonObjectPattern(_ input: String) -> Bool {
        
        return true
    }
    
}
