//
//  ArrayTokenizer.swift
//  JSONParser
//
//  Created by 김성현 on 07/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct ArrayTokenizer {
    
    func tokenize(string: String) throws -> [String] {
        var string = string
        var tokenized = [String]()
        var hasDetectedArray = false
        var hasDetectedString = false
        
        guard string.removeFirst() == "[", string.removeLast() == "]" else {
            throw ArrayTokenizerError.invalidArrayFormat
        }
        string.removeLast()
        string.removeFirst()
        
        for character in string {
            switch character {
            case " " where !hasDetectedString:
                continue
            }
        }
        
        return tokenized
        
    }
    
    
    
    
}

enum ArrayTokenizerError: Error {
    case invalidArrayFormat
}
