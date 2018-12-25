//
//  main.swift
//  JSONParser
//
//  Created by Elena on 20/12/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

func parsingMain() {
    let userInputData = InputView.getUserString()
    let result = Parser.DivideData(from: userInputData)
    guard let printResultData = result else {
        OutputView().errorResult()
        return
    }
    let resultData = ParserData.init(printResultData)
    OutputView().parserResultData(resultData)
}

parsingMain()
