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
    //err 'nil'
    guard let printResultData = result else {
        OutputView().errorResult()
        return
    }
    // [ ]
    if  !printResultData.ObjectData.isEmpty {
        let resultObjectData = Parser.parseBracket(printResultData.ObjectData)
        guard let result = resultObjectData else {
            OutputView().errorResult()
            return
        }
        let resultData = ParserObjectData.init(result)
        OutputView().parserResultData(resultData)
        return
    }
    // { }
    let resultData = ParserData.init(printResultData)
    OutputView().parserResultData(resultData)
}

parsingMain()
