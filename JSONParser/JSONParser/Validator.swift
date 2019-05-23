//
//  Validator.swift
//  JSONParser
//
//  Created by CHOMINJI on 14/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Validator: Validatable {
    
    
}

protocol Validatable {
    func hasQuotation(in token: String) -> Bool
    func isBool(of token: String) -> Bool
    func isNumber(of token: String) -> Bool
}
