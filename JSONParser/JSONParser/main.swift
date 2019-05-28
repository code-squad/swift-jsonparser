//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

struct JSONAnalyzer{
    static func run() {
        var errorOccurred: Bool = false
        repeat{
            do{
                let inputView = InputView()
                let userInput = inputView.run()
                var tokenizer = MyTokenizer.init(userInput)
                let tokens = try tokenizer.tokenize()
                var parser = MyListParser.init(tokens: tokens)
                let result = parser.parse()
                var outPutview = OutputView.init(numOf: result)
                outPutview.run()
                errorOccurred = false
            }catch {
                errorOccurred = true
                print(error)
            }
        }while errorOccurred
    }
}

JSONAnalyzer.run()

