//
//  main.swift
//  JSONParser
//
//  Created by Jack (2017/12/19)
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

let outputView : OutputView = OutputView()
var runJSONParser : Bool = true
var outputFileName = ""
var userInput = ""

while runJSONParser {

    if CommandLine.arguments.count == 1 {
        outputView.printMessages(.inputMessage)
        userInput = InputView().readConsoleInput()
        guard userInput != "q" else { break }
    }
    if CommandLine.arguments.count >= 2 {
        userInput = try InputView().readFile(CommandLine.arguments[1])
        outputFileName = CommandLine.arguments[2]
        CommandLine.arguments.removeSubrange(1...2)
    }

    guard GrammarChecker().isValid(userInput: userInput) else {
        outputView.printMessages(.formatError)
        continue
    }
    let convertedData = DataFactory().generateData(userInput)
    let numbersOfData = DataCounter().countNumberOfData(convertedData)
    
    if CommandLine.arguments.count == 3 {
        outputView.
    }
    
    outputView.printCountOfData(numbersOfData)
    outputView.printShapeOfData(convertedData)
    
}
