//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//


let inputView = InputView()
let userInput = inputView.askUserInput()

let grammarChecker = GrammarChecker()
var parseTarget = ([String](),"")

do {
    parseTarget = try grammarChecker.execute(userInput)
    let convertedValues = try Parser.matchValues(parseTarget)
    let counter = ValueCounter(targetToCount: convertedValues)
    let countInfo = counter.makeCountInfo()
    let outputView = OutputView()
    outputView.showResult(countInfo)
} catch let error as GrammarChecker.FormatError {
    switch error {
    case .invalidArray:
        print(GrammarChecker.FormatError.invalidArray.description)
    case .invalidObject:
        print(GrammarChecker.FormatError.invalidObject.description)
    }
}





