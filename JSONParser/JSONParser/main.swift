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
    let inputView = InputView()
    let inputData = inputView.readInput(message)
    guard GrammarChecker().isValidInput(inputData) else { print("정확한 데이터 값으로 다시 입력하세요"); continue }
    let checkData = inputView.checkBrackets(inputData)
    guard checkData.bool else { ResultView().resultArrayMessage(checkData.value); continue }
    let dictionaryData = MyJsonParser().makeDictionary(checkData.value)
    ResultView().resultDicionaryMessage(dictionaryData)
}



