//
//  JSONValidationRule.swift
//  JSONParser
//
//  Created by BLU on 22/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONValidationRule: ValidationRule {
    func isValid(_ value: String) -> Bool {
        return value =~ Regex.jsonObject || value =~ Regex.jsonArray
    }
}
