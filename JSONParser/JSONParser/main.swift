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
    let input = InputView().readInput(message)
    let from = GrammarChecker().isFormInput(input)
    guard from else { print("[1, 2, \"a\", true, 3] 형식으로 다시 입력 하세요"); continue }
    let inputData = InputView().makeDataArray(input)
    let dataCount = InputView().countData(inputData)
    let validValue = GrammarChecker().isValidInput(dataCount.numberData)
    guard validValue else { print("정확한 데이터 값으로 다시 입력하세요"); continue }
    ResultView().resultMessage(dataCount.number, dataCount.string, dataCount.bool, dataArray: inputData)
}


