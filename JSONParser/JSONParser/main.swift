//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

let inputView = InputView()
let arguments = CommandLine.arguments
var commandLineInput = (inputContents: "", outputPath: "", type: InputView.InputType.console)
var runProgram : Bool = true

while runProgram {
    do {
        commandLineInput = try inputView.readCommandLine(arguments)
    } catch let error {
        switch error {
        case InputView.InputError.noFile:
            print(InputView.InputError.noFile)
        case InputView.InputError.voidFile:
            print(InputView.InputError.voidFile)
        default :
            print(InputView.InputError.noFile
            )
        }
        break
    }
    
    let grammarChecker = GrammarChecker()
    var parseTarget = (parseValue: [String](), parseType: Parser.ParseTarget.list)
    var convertedValues : JSONData = JSONData.IntegerValue(0)
    do {
        parseTarget = try grammarChecker.execute(commandLineInput.inputContents)
        convertedValues = try Parser.matchValues(parseTarget)
    } catch let error as GrammarChecker.FormatError {
        runProgram = false
        switch error {
        case .invalidArray:
            print(GrammarChecker.FormatError.invalidArray)
        case .invalidObject:
            print(GrammarChecker.FormatError.invalidObject)
        case .invalidInput:
            print(GrammarChecker.FormatError.invalidInput)
        }
        break
    }
    
    let counter = ValueCounter(targetToCount: convertedValues)
    let countInfo = counter.makeCountInfo()
    let outputView = OutputView(resultType: commandLineInput.type)
    let resultText = ResultData().make(convertedValues)
    if commandLineInput.outputPath == "" {
        outputView.consoleResult(countInfo, parseTarget.parseType, text: resultText)
    } else {
        outputView.makeFile(text: resultText, path: commandLineInput.outputPath)
    }
    break
}



