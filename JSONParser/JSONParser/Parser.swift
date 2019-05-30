//
//  Parser.swift
//  JSONParser
//
//  Created by CHOMINJI on 19/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Parser {
    
    private var converter: JSONConvertible
    
    init(converter: JSONConvertible) {
        self.converter = converter
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
        guard let value = converter.convert(token: token) else {
            return nil
        }
        return value
    }
}
