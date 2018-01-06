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

switch arguments.count {
case 1:
let userInput = inputView.askUserInput(message: "분석할 JSON 문자열을 입력하세요.")
guard let inputString = userInput else {
    throw GrammarChecker.FormatError.invalidInput
    }
commandLineInput = (input: inputString, output: "")
//parse(jsonString: commandLineInput.input)

case 2: print(2)
case 3: print(3)
default: print("default")
}


// readCommandLine
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

var convertedValues : JSONData = JSONData.IntegerValue(0)
var parseTarget = (parseValue: [String](), parseType: Parser.ParseTarget.list)



// parse - for all cases of input
func parse(jsonString: String) {
let grammarChecker = GrammarChecker()
    do {
        parseTarget = try grammarChecker.execute(jsonString)
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
    catch let unKnownError {
        print("Unknown error occured!: \(unKnownError)")
    }
}



let counter = ValueCounter(targetToCount: convertedValues)
let countInfo = counter.makeCountInfo()
let outputView = OutputView()
let resultData = ResultData()
let resultText = resultData.make(convertedValues)


// outputType
func showOutputOnConsole() {
    outputView.showResult(countInfo, parseTarget.parseType, text: resultText)
}

func makeOutputAsFile() {
    outputView.makeOutputFile(text: resultText, file: commandLineInput.output)
}

