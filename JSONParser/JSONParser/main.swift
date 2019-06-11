//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

let userInput = InputView.readPrompt(for: "분석할 JSON 데이터를 입력하세요.")

let tokens = Tokenizer.tokenize(from: userInput)
var parser = Parser.init(tokens: tokens)
if let jsonDatas = parser.parse() {
    OutputView.printDescription(of: jsonDatas)
}

// { "name" : "MINJI CHO", "alias" : "mindy", "level" : 2, "married" : false }

// [ { "name" : "MINJI CHO", "alias" : "mindy", "level" : 2, "married" : false },{ "name" : "HELLO HI", "alias" : "hi", "level" : 4, "married" : true } ]

// [ { "name" : "MINJI CHO", "alias" : "mindy", "level" : 2, "married" : false },true, "hihi", false, { "name" : "HELLO HI", "alias" : "hi", "level" : 4, "married" : true } ]

// [ { "name" : "MINJI CHO", "alias" : "mindy", "level" : 2, "married" : false },{ "name" : "HELLO HI", "alias" : "hi", "level" : 4, "married" : true }, true, "hello, world!", "{}{" ]
