//
//  ArrayTokenizer.swift
//  JSONParser
//
//  Created by 김성현 on 07/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct ArrayTokenizer {
    
    static func tokenize(string: String) throws -> [String] {
        var string = string
        guard string.first == "[", string.last == "]" else {
            throw ArrayTokenizerError.invalidArrayFormat
        }
        string.removeLast()
        string.removeFirst()
        let tokenized = string.split(separator: ",").map { String($0) }
        return tokenized
    }
    
    
    
    
}

enum ArrayTokenizerError: Error {
    case invalidArrayFormat
}
