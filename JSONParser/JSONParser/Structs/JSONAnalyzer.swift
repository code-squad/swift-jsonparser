//
//  JSONAnalyzer.swift
//  JSONParser
//
//  Created by 이동영 on 22/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONAnalyer {
    let hander = ErrorHandler.init{
        error in
        ErrorPrinter.print(error)
        exit(0)
    }
    
    func run(){
        let inputView = InputView.init()
        let userInput = inputView.run()
        self.hander.handle {
            guard GrammerChecker.check(format: userInput) else {
                throw AnalyerException.grammerException
            }
        }
        var tokens: [Token] = []
        hander.handle {
            tokens = try MyTokenizer.tokenize(string: userInput)
        }
        let result = JsonParser.run(tokens: tokens)
        let jsonContainer = result.value
        let outputView = OutputView.init()
        outputView.output(jsonContainer)
    }
    
}
