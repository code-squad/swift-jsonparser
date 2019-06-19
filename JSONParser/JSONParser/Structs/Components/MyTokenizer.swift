//
//  MyTokenizer.swift
//  JSONParser
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct MyTokenizer: Tokenizer {
    private let factory = TokenFactory()
    private var scanner: Scanner
    private var string: String
    
    init(_ string: String) {
        self.string = string
        self.scanner = MyScanner.init(string: string)
    }
    
    mutating func tokenize() -> [Token] {
        let units = self.split()
        let tokens = units.map {
            self.factory.create(string: $0)
        }
        return tokens
    }
    
    private func split() -> [String] {
        let pattern = Pattern.tokens
        
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in: self.string, options: [], range: self.string.range)
        let units = matches.map {
            NSString.init(string: self.string).substring(with: ($0.range))
        }
        return units
    }
}
