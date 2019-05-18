//
//  MyTokenizer.swift
//  JSONParser
//
//  Created by 이동영 on 19/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct MyTokenizer: Tokenizer {
    var lexer: Lexer = MyLexer()
    
    func tokenize(_ string: String) -> [Token] {
        return []
    }
}
