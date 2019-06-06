//
//  Lexer.swift
//  JSONParser
//
//  Created by JieunKim on 05/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONLexer {
    static func analyze(data: [String]) throws -> [String] {
        guard data.first == Token.beginArray && data.last == Token.endArray else {
            throw JSONError.notArray
        }
        var data = data
        data.removeFirst()
        data.removeLast()
        var isAnalyzingValue = true
        var result = [String]()

        func readLexical(string: String) throws {
            if string == Token.valueSeparator {
                if isAnalyzingValue {
                    throw JSONError.unexpectedSeperator
                } else {
                    isAnalyzingValue = true
                }
            } else {
                if !isAnalyzingValue {
                    throw JSONError.unexpectedSeperator
                } else {
                    result.append(string)
                    isAnalyzingValue = false
                }
            }
        }
        
        for string in data {
            try readLexical(string: string)
        }
        return result
    }
}
