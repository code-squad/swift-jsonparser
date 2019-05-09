//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation


let parseInputJsonData = { (data: String) -> JsonDictionary in
    /// 1) Tokenize
    let tokenizedInput = Tokenizer.tokenize(data)
    /// 2) Lexical analysis
    var lexiedInput: [LexPair] = [LexPair]()
    do {
        lexiedInput = try Lexer.analyzeLexing(tokenList: tokenizedInput)
    } catch let errorType as ErrorCode  {
        print(errorType.description)
    }
    /// 3) Parse
    return Parser.parseLexerResult(lexiedInput)
}


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
    /// 처리
    let parsingResult = try parseInputJsonData(data)
    
    /// 출력
    OutputView.printJsonInformation(parsingResult)
    print(parsingResult.getJsonFormmat)
}

try main()
