//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//
//


import Foundation
do {
    let inputView = InputView()
    let userInput = inputView.run()
    let checker = GrammerChecker()
    guard checker.check(format: userInput) else {
        throw GrammerChecker.Error.unsupportedFormat
    }
    var tokenizer = MyTokenizer.init(userInput)
    let tokens = tokenizer.tokenize()
    let result = JsonParser.run(tokens: tokens)
    let jsonContainer = result.value
    let outputView = OutputView.init()
    outputView.output(jsonContainer)
}catch {
    ErrorHandler.handle(error: error)
}
