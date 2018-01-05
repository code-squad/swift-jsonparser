//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//


let inputView = InputView()
let arguments = CommandLine.arguments
var commandLineInput = (input: "", output: "")
do {
    commandLineInput = try inputView.readCommandLine(arguments)
} catch let error {
    switch error {
    case InputView.InputError.noFile:
        print(InputView.InputError.noFile)
    case InputView.InputError.voidFile:
        print(InputView.InputError.voidFile)
    default :
        print(InputView.InputError.voidFile) //String init()에서의 에러
    }
}
    
let grammarChecker = GrammarChecker()
var parseTarget = (parseValue: [String](), parseType: Parser.ParseTarget.list)
var convertedValues : JSONData = JSONData.IntegerValue(0)

do {
    parseTarget = try grammarChecker.execute(commandLineInput.input)
    convertedValues = try Parser.matchValues(parseTarget)
} catch let error as GrammarChecker.FormatError {
    switch error {
    case .invalidArray:
        print(GrammarChecker.FormatError.invalidArray)
    case .invalidObject:
        print(GrammarChecker.FormatError.invalidObject)
    case .invalidInput:
        print(GrammarChecker.FormatError.invalidInput)
    }
}

let counter = ValueCounter(targetToCount: convertedValues)
let countInfo = counter.makeCountInfo()
let outputView = OutputView()
let resultData = ResultData()
let resultText = resultData.make(convertedValues)
outputView.showResult(countInfo, parseTarget.parseType, text: resultText)
outputView.makeOutputFile(text: resultText, file: commandLineInput.output)




