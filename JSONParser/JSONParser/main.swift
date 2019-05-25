//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation


func run() {
    var errorOccurred: Bool = false
    repeat{
        do{
            let inputView = InputView()
            let userInput = inputView.run()
            var tokenizer = MyTokenizer.init(string: userInput)
            let tokens = try tokenizer.tokenize()
            let counter = TokenCounter.count(tokens: tokens)
            var outPutview = OutputView.init(numOf: counter)
            outPutview.run()
            errorOccurred = false
        }catch {
            errorOccurred = true
            print(error)
        }
    }while errorOccurred
}


run()
