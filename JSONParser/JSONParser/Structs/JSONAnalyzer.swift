//
//  JSONAnalyzer.swift
//  JSONParser
//
//  Created by 이동영 on 11/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//


import Foundation

struct JSONAnalyzer{
    static func run() {
        var errorOccurred: Bool = false
        repeat {
            do {
                let inputView = InputView()
                let userInput = inputView.run()
                var tokenizer = MyTokenizer.init(userInput)
                var tokens = try tokenizer.tokenize()
                let parser = JsonParser.init()
                let jsonValue = parser.parse(tokens: &tokens)
                var outputView = OutputView.init(jsonValue)
                outputView.run()
                errorOccurred = false
            } catch {
                errorOccurred = true
                print(error)
            }
        } while errorOccurred
    }
}
