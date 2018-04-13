//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

while true {
    let message = "분석할 JSON 데이터를 입력하세요."
    let inputData = InputView().readInput(message)
    let grammarChecker = GrammarChecker()
    guard grammarChecker.isValidFirstString(inputData) && grammarChecker.isValidLastString(inputData) else {
        print("지원하지 않는 형식을 포함하고 있습니다.")
        continue }
    guard let jsonData = MyJsonParser().checkBrackets(inputData) else { break }
    let myDataCount = jsonData.countJSONData()
    let printMessage = jsonData.resultMessage(myDataCount)
    ResultView().printMessage(printMessage)
}




