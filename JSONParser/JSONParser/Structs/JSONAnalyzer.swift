//
//  JSONAnalyzer.swift
//  JSONParser
//
//  Created by 이동영 on 11/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//


import Foundation

struct JSONAnalyzer{
    
    func run() throws {
        let inputView = InputView()
        let userInput = inputView.run()
        let checker = GrammerChecker()
        guard checker.check(format: userInput) else {
            throw Error.wrongFormat
        }
        var tokenizer = MyTokenizer.init(userInput)
        let tokens = tokenizer.tokenize()
        let result = JsonParser.run(tokens: tokens)
        let jsonContainer = result.value
        var outputView = OutputView.init(jsonContainer)
        outputView.run()
    }
    
}
// -MARK:Error
extension JSONAnalyzer {
    enum Error: Swift.Error {
        case wrongFormat
        
        var localizedDescription: String {
            switch self {
            case .wrongFormat:
                return "지원하지 않는 JSON형식 입니다."
            }
        }
    }
}
