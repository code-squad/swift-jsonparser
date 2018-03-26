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
    guard GrammarChecker().isValidInput(inputData) else { print("정확한 데이터 값으로 다시 입력하세요"); continue }
    guard let jsonData = MyJsonParser().checkBrackets(inputData) else { break }
    let resultView = ResultView()
    resultView.resultMessage(jsonData)
}


