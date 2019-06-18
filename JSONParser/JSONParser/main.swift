//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main() {
    let userInput = InputView.readPrompt(for: "분석할 JSON 데이터를 입력하세요.")
    
    guard GrammerChecker.isJSONFormat(of: userInput) else {
        print("지원하지 않는 형식이 포함되어 있습니다.")
        return
    }
    
    let tokens = Tokenizer.tokenize(from: userInput)
    let tokenScanner = TokenScanner(tokens: tokens)
    
    let parser = Parser(tokens: tokens, scanner: tokenScanner)
    if let jsonData = parser.parse() {
        OutputView.printDescription(of: jsonData)
    }
}

main()

// { "name" : "MINJI CHO", "alias" : "mindy", "level" : 2, "married" : false }

// [ { "name" : "MINJI CHO", "alias" : "mindy", "level" : 2, "married" : false },{ "name" : "HELLO HI", "alias" : "hi", "level" : 4, "married" : true } ]

// [ { "name" : "MINJI CHO", "alias" : "mindy", "level" : 2, "married" : false },true, "hihi", false, { "name" : "HELLO HI", "alias" : "hi", "level" : 4, "married" : true } ]

// [ { "name" : "MINJI CHO", "alias" : "mindy", "level" : 2, "married" : false },{ "name" : "HELLO HI", "alias" : "hi", "level" : 4, "married" : true }, true, "hello, world!", "{}{" ]
