//
//  MyParser.swift
//  JSONParser
//
//  Created by 이동영 on 25/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct MyParser: Parser {
    let tokens: [Token]
    private var numOf: [TokenType: Int]
    private var total: Int = 0
    
    init(tokens:[Token]) {
        self.tokens = tokens
        numOf = TokenCounter.count(tokens: tokens)
    }
    
    mutating func parse() -> String {
        return self.makeSentence()
    }
    
    private mutating func statistics() -> String {
        var result = ""
        _ = self.numOf.map{ (type,count) in
            self.total += count
            result += " \(type) \(count)개, "
        }
        return result
    }
    
    private mutating func makeSentence() -> String {
        let statistics = self.statistics()
        var sentence = "총 \(self.total)개의 데이터 중에 "
        sentence += statistics
        sentence += "포함되어 있습니다."
        return sentence
    }
    
}
