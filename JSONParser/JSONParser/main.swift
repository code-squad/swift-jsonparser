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
var isJSONPattern: Bool = false
while !isJSONPattern {
    print("분석할 JSON 데이터를 입력하세요.")
    inputValue = InputView.readInput()
    isJSONPattern = grammarChecker.isJSONPattern(target: inputValue)
    if !isJSONPattern {
        print("지원하지 않는 형식을 포함하고 있습니다.")
    }
}
// 분석
let jsonAnalyser = JSONAnalyser.init(grammarChecker: grammarChecker)
let jsonType = jsonAnalyser.getJSONType(inputValue: inputValue)
// JSON 형식
var jsonPainter = JSONPainter()
jsonPainter.paintJSON(jsonType: jsonType)
// 출력
let outputView = OutputView.init(jsonType: jsonType)
outputView.printResult()
outputView.printJSON(jsonPainter: jsonPainter)
