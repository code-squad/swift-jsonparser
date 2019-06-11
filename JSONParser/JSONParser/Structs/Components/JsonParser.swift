//
//  MyListParser.swift
//  JSONParser
//
//  Created by 이동영 on 29/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonParser {
    private var tokens: Array<Token>
    var strategy: JsonParsingStrategy
    var jsonValue: JsonValue
    
    init(tokens: Array<Token>) {
        self.tokens = tokens
        self.strategy =
            tokens[0] == Token.LeftBraket ?
                JsonListParsingStrategy() : JsonObjectParsingStrategy()
        self.jsonValue = tokens[0] == Token.LeftBraket ?
                JsonList() : JsonObject()
        self.mergeStringTokens()
    }
    
    mutating func parse() -> JsonValue {
        self.grouping()
        return self.strategy.parse(tokens: self.tokens)
    }
    
    mutating func grouping() {
        
    }
    
    func extract(){
        
    }
    
    mutating func grouping2() {
        var tokens = Array<Token>()
        var removingTokenIndex = MyStack<Int>()
        var ing = false
        for (index, token) in self.tokens.enumerated() {
            if token == .LeftBrace || token == .RightBrace {
                ing.toggle()
                if !ing {
                    self.tokens.append(token)
                    self.tokens[index] = .List(tokens)
                    tokens.removeAll()
                }
                continue
            }
            if ing {
                tokens.append(token)
                removingTokenIndex.push(index)
            }
        }
        self.remove(indexs: &removingTokenIndex)
    }
    
    private mutating func mergeStringTokens() {
        var contents = ""
        var removingTokenIndex = MyStack<Int>()
        var ing = false
        for (index, token) in self.tokens.enumerated() {
            if token == .DoubleQuotation {
                ing.toggle()
                if !ing {
                    self.tokens[index] = .String(contents)
                    contents = ""
                }
                continue
            }
            if ing {
                contents += token.getValue()
                removingTokenIndex.push(index)
            }
        }
        self.remove(indexs: &removingTokenIndex)
    }
    
    private mutating func remove(indexs: inout MyStack<Int>) {
        while let removingIndex = indexs.pop() {
            self.tokens.remove(at: removingIndex)
        }
    }
    
    private mutating func set(strategy: JsonParsingStrategy) {
        self.strategy = strategy
    }
    
}
