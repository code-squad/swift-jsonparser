//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

var inputView = InputView()
var outputView = OutputView()
var tokenizer = Tokenizer()
var parser = Parser()

outputView.show(string: "Json데이터를 입력하세요")
let input = inputView.ask(data: "Json데이터")
let tokens = tokenizer.tokenize(input: input)

do {
    let jsonData = try parser.startParsing(tokens: tokens)
    if let countableData = jsonData as? Countable {
        outputView.showCount(typeName: jsonData.typeName, countInfo: countableData.countInfo )
    }
} catch {
    outputView.show(string: "\(error)")
}

