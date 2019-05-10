//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

struct Main {
    static private func parseInputJsonData (_ data: String) throws-> JsonDictionary {
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
    
    static func main () throws {
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
        let jsonFormat = JsonFormatter.init(jsonDictionary: parsingResult)
        OutputView.printJsonInformation(jsonFormat)
    }
}
try Main.main()
