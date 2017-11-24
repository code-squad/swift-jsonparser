//
//  main.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 22..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

func main() throws {
    do {
        let userFileNames = try InputView.terminalMode()
        let userData = try InputView.getData(from: userFileNames.0)
        // JSON 규격 여부 검사.
        guard try GrammarChecker.isJSONPattern(userData) else { throw GrammarChecker.JsonError.invalidPattern }
        let jsonData = try JSONParser.parse(userData)
        let report = jsonData.generateJSONReport()
        let prettyData = jsonData.generatePrettyJSONData()
        if let outputFileName = userFileNames.1 {
            try OutputView.writeData(prettyData, into: outputFileName)
        }else {
            print(report, "\n")
            print(prettyData)
        }
    }catch let e as GrammarChecker.JsonError {
        OutputView.printError(e)
    }
}

try main()
