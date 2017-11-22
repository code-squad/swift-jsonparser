//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

var inputValue: String = ""
let grammarChecker: GrammarChecker = GrammarChecker()
// 입력
let inputView: InputView = InputView.init(grammarChecker: grammarChecker)

let commandCount: Int = CommandLine.arguments.count
switch commandCount {
case 2,3:
    do {
        inputValue = try inputView.readFromFile()
    } catch GuideMessage.notJSONPattern {
        print(GuideMessage.notJSONPattern.rawValue)
    } catch {
        print(GuideMessage.wrongInput.rawValue)
    }
default:
    var isJSONPattern: Bool = false
    while !isJSONPattern {
        print(GuideMessage.inputRequest.rawValue)
        inputValue = inputView.readFromConsole()
        isJSONPattern = grammarChecker.isJSONPattern(target: inputValue)
        if !isJSONPattern {
            print(GuideMessage.notJSONPattern.rawValue)
        }
    }
}

// 분석
let jsonAnalyser = JSONAnalyser()
let jsonType = jsonAnalyser.getJSONType(inputValue: inputValue)
// JSON 형식
var jsonPainter = JSONPainter()
jsonPainter.paintJSON(jsonType: jsonType)
// 출력
let outputView = OutputView.init(jsonType: jsonType)
outputView.printResult(jsonPainter: jsonPainter)
