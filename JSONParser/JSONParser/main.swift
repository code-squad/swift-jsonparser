//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

// 초기화
let commandCount: Int = CommandLine.arguments.count
var file: String = ""
if commandCount > 1 {
    file = CommandLine.arguments[1]
}
let grammarChecker: GrammarChecker = GrammarChecker()
// 입력
let inputView: InputView = InputView()
var inputValue: String = ""
while inputValue.count == 0 {
    if commandCount == 1 {
        print(GuideMessage.inputRequest.rawValue)
    }
    do {
        inputValue = try inputView.readInput(file: file)
    } catch {
        print(GuideMessage.invalidFile.rawValue)
        file = inputView.readFromConsole()
        continue
    }
    if !grammarChecker.isJSONPattern(target: inputValue) {
        print(GuideMessage.notJSONPattern.rawValue)
        inputValue = ""
        if commandCount > 1 {
            print(GuideMessage.invalidFile.rawValue)
            file = inputView.readFromConsole()
        }
    }
}
// 분석
let jsonAnalyser = JSONAnalyser()
let jsonType = jsonAnalyser.getJSONType(inputValue: inputValue)
// JSON 형식
var jsonPainter = JSONPainter(jsonType: jsonType)
let jsonResult: String = jsonPainter.getJSONResultAll()
// 출력
let outputView = OutputView()
switch commandCount {
case 2:
    outputView.printResult(jsonResult: jsonResult, newFileName: GuideMessage.defaultFileName.rawValue)
case 3:
    outputView.printResult(jsonResult: jsonResult, newFileName: CommandLine.arguments[2])
default:
    outputView.printResult(jsonResult: jsonResult, newFileName: "")
}
