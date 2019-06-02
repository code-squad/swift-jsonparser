//
//  Tokenizer.swift
//  JSONParser
//
//  Created by CHOMINJI on 19/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Tokenizer {

    static func tokenize(from prompt: String) -> [String] {
        var token: String = ""
        var tokens: [String] = []
        
        var isInString = false
        let delimiters = [JSONKeyword.whiteSpace, JSONKeyword.comma].map { Character($0) }
        let brackets = [JSONKeyword.leftCurlyBracket, JSONKeyword.leftSquareBracket, JSONKeyword.rightSquareBracket, JSONKeyword.rightCurlyBracket]
            .map { Character($0) }
        
        for character in prompt {
            
            guard !brackets.contains(character) else {
                tokens.append(String(character))
                continue
            }
            
            if character == Character(JSONKeyword.quotation) {
                isInString.toggle()
            }
            
            guard !isInString else {
                token.append(character)
                continue
            }

            guard delimiters.contains(character) else {
                token.append(character)
                continue
            }

            tokens.append(token)
            token = ""
        }
        
        print(tokens)
        return tokens
    }
    // { "name" : "MINJI CHO", "alias" : "mindy", "level" : 2, "married" : false }
    // [ { "name" : "MINJI CHO", "alias" : "mindy", "level" : 2, "married" : false },{ "name" : "HELLO HI", "alias" : "hi", "level" : 4, "married" : true } ]
}

extension String {
    func splitByLeftBracket() -> String {
        return self.replacingOccurrences(of: JSONKeyword.leftSquareBracket, with: JSONKeyword.whiteSpace)
    }
    
    func splitByRightBracket() -> String {
        return self.replacingOccurrences(of: JSONKeyword.rightSquareBracket, with: JSONKeyword.whiteSpace)
    }
}

struct Stack<Element> {
    fileprivate var array: [Element] = []

    var isEmpty: Bool {
        return array.isEmpty
    }

    var count: Int {
        return array.count
    }

    mutating func push(_ element: Element) {
        array.append(element)
    }

    mutating func pop() -> Element? {
        return array.popLast()
    }

    mutating func peek() -> Element? {
        return array.last
    }
}
