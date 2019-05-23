//
//  MyTokenizer.swift
//  JSONParser
//
//  Created by 이동영 on 19/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct MyTokenizer: Tokenizer {
    private var scanner: Scanner
    
    init(string: String) {
        self.scanner = Scanner.init(string: string)
    }
    
    mutating func tokenize() throws -> [Token] {
        var strings = [String]()
        while(scanner.hasNext()){
            strings.append(try scanner.next())
        }
        let tokens = strings.map { TokenGenerater.createToken($0) }
        return tokens.filter {  ![TokenType.Array,TokenType.None].contains($0.type) }
    }
    
}

