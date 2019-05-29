//
//  Parser.swift
//  JSONParser
//
//  Created by BLU on 2019. 5. 29..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

struct Parser {
    
    private let tokens: [Token]
    private var position = 0
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
}
