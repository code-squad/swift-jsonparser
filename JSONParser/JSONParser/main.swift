//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation


//[ 10, "jk", 4, "314", 99, "crong", false ]
let main = {
    /// 입력
    var data = ""
    while true {
        do {
            data = try InputView.readStringJsonData()
            try Validation.checkInvalidArrayFormat(data)
            break
        } catch let errorType as ErrorCode  {
            print(errorType.description)
        }
    }
    /// 처리 1) Tokenize
    let tokenizedInput = Tokenizer.tokenize(data)
    /// 처리 2) Lexical analysis
    var lexiedInput: [LexPair] = [LexPair]()
    do {
        lexiedInput = try Lexer.doLexcialAnalysis(tokenList: tokenizedInput)
    } catch let errorType as ErrorCode  {
        print(errorType.description)
    }
    /// 처리 3) Parse
    let parsingResult = Parser.parseLexerResult(lexiedInput)
    
    /// 출력
    OutputView.printJsonInformation(parsingResult)
}

try main()
