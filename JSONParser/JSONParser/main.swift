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
var isError: Bool = true
while isError {
    print(GuideMessage.inputRequest.rawValue)
    do {
        inputValue = try inputView.readInput(isError: isError)
        isError = false
    } catch  GuideMessage.notJSONPattern {
        isError = true
        print(GuideMessage.notJSONPattern.rawValue)
    } catch {
        isError = true
        print(GuideMessage.wrongInput.rawValue)
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
