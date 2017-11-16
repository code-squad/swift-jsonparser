//
//  main.swift
//  JSONParser
//
//  Created by 심 승민 on 11/06/2017.
//  Copyright © 2017 심 승민. All rights reserved.
//

import Foundation

func main() throws {
    while true {
        do {
            guard let userInput = try InputView.askFor(message: "분석할 JSON 데이터를 입력하세요: ") else { return }
            // JSON 규격 여부 검사.
            guard try GrammarChecker.isJSONPattern(userInput) else { throw GrammarChecker.JsonError.invalidPattern }
            let jsonData = try JSONParser.parse(userInput)
            try OutputView(jsonData).printReport()
        }catch let e as GrammarChecker.JsonError {
            OutputView.printError(e)
            continue
        }
    }
}

try main()
