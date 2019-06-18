//
//  Tokenizer.swift
//  JSONParser
//
//  Created by JH on 08/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Tokenizer {
    /// 입력받은 문자열을 모두쪼개서 배열로반환하는 메소드
    func tokenize(input: String) -> [String] {
        var tokens = Array<String>()
        
        for token in input {
            tokens.append(String(token))
        }
        
        return tokens
    }
}
