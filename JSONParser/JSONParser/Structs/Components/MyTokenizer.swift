//
//  MyTokenizer.swift
//  JSONParser
//
//  Created by 이동영 on 19/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct MyTokenizer: Tokenizer {
    var scanner: Scanner
    
    init(string: String) {
        self.scanner = Scanner.init(string: string)
    }
    
    mutating func tokenize() throws -> [Token] {
        return []
    }
    
    
}

