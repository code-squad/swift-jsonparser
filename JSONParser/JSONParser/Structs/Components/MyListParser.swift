//
//  MyListParser.swift
//  JSONParser
//
//  Created by 이동영 on 29/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct MyListParser: Parser {
    private var statistics: Dictionary<Token, Int>
    private var tokens: Array<Token>
    
    init(tokens: Array<Token>) {
        self.tokens = tokens
        self.statistics = Dictionary<Token, Int>()
    }
    
    mutating func parse() -> Dictionary<Token, Int> {
        self.assembleToken()
        _ = self.tokens.map{ self.statistics[$0] = (self.statistics[$0] ?? 0) + 1 }
       return self.statistics.filter{ !Token.symbols.contains($0.key) }
    }
    
    private mutating func assembleToken() {
        var isString = false
        var indexs = MyStack<Int>()
        for (index,token) in self.tokens.enumerated() {
            if isString {
                indexs.push(index)
            }
            if(token == .DoubleQuotation){
                isString.toggle()
                self.tokens[index] = .String
            }
        }
        while !indexs.isEmpty(){
            guard let index = indexs.pop() else { return }
            self.tokens.remove(at: index )
        }
    }
    
}



