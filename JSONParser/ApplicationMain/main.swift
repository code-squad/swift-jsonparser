//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

struct Main {
    static private func parseInputJsonData (_ data: String) throws -> JsonParsable {
        let tokenizer : Tokenizer = Tokenizer()
        let tokenList = try tokenizer.tokenize(data)
        let result = try Parser.composeToken(tokenList)
        return result
    }
    
    static func main () throws {
        /// 입력
        var data = ""
        while true {
            do {
                data = try InputView.readStringJsonData()
                try Validation.checkInvalidJsonArrayFormat(data)
                break
            } catch let errorType as ErrorCode  {
                print(errorType.description)
            }
        }
        /// 처리
        let parsingPairResult = try parseInputJsonData(data)
        /// 포맷 변환 후 출력
        let jsonFormat : JsonFormatter
        do {
            jsonFormat = try JsonFormatter.init(jsonData: parsingPairResult)
            OutputView.printJsonInformation(jsonFormat)
        } catch let error as ErrorCode {
            print("\(error.description)")
        }
    }
}

try Main.main()

