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
