//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by BLU on 20/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    
    static func isValidFormat(_ value: String, rule: (String) -> Bool) -> Bool {
        return rule(value)
    }
}
