//
//  Tokenizer.swift
//  JSONParser
//
//  Created by 이동영 on 18/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol Tokenizer {
    var lexer:Lexer { get }
    func tokenize(_ string:String) -> [Token]
}

