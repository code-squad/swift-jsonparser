//
//  JSONValidationRule.swift
//  JSONParser
//
//  Created by BLU on 22/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONValidationRule: ValidationRule {
    private let arrayPattern = #"^\[ ?((|, ?)(\"[\w ]+\"|[\d]+|true|false|(\{ ?((|, ?)(\"[\w]+\" ?: ?)(\"[\w ]+\"|[\d]+|true|false))+ ?\})))+ ?\]$"#
    private let objectPattern = #"^\{ ?((|, ?)(\"[\w]+\" ?: ?)(\"[\w ]+\"|[\d]+|true|false))+ ?\}$"#
    
    func isValid(_ value: String) -> Bool {
        return value.matches(arrayPattern) || value.matches(objectPattern)
    }
}

extension String {
    func matches(_ pattern: String) -> Bool {
        return self.range(of: pattern, options: .regularExpression) != nil
    }
}
