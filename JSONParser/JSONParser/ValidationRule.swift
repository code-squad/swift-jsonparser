//
//  ValidationRule.swift
//  JSONParser
//
//  Created by BLU on 21/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol ValidationRule {
    func isValid(_ value: String) -> Bool
}

struct JSONValidationRule: ValidationRule {
    private let arrayPattern = #"^\[ ?((|, ?)(\"[\w ]+\"|[\d]+|true|false|(\{ ?((|, ?)(\"[\w]+\" ?: ?)(\"[\w ]+\"|[\d]+|true|false))+ ?\})))+ ?\]$"#
    private let objectPattern = #"^\{ ?((|, ?)(\"[\w]+\" ?: ?)(\"[\w ]+\"|[\d]+|true|false))+ ?\}$"#
    
    func isValid(_ value: String) -> Bool {
        return value.matches(for: arrayPattern) || value.matches(for: objectPattern)
    }
}

extension String {
    func matches(for regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression) != nil
    }
}
