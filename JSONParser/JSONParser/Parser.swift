//
//  Parser.swift
//  JSONParser
//
//  Created by CHOMINJI on 19/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Parser {
    
    private var validator: Validatable
    
    init(validator: Validatable) {
        self.validator = validator
    }
    
    func parse(tokens: [String]) -> [JSONValueType] {
        var values: [JSONValueType] = []
        
        for token in tokens {
            guard let value = makeJSONType(by: token) else {
                continue
            }
            values.append(value)
        }
        return values
    }
    
    private func makeJSONType(by token: String) -> JSONValueType? {
        guard let value = validator.checkType(of: token) else {
            return nil
        }
        return value
    }
}
