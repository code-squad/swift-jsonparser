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
    let input = inputView.readInput(message)
    let inputData = inputView.separateByComma(input)
    let data = inputView.dropBrackets(inputData)
    let dataValue = inputView.removeWhiteSpace(data)
    let dataType = inputView.makeDataArray(dataValue)
    ResultView().resultMessage(dataType.number, dataType.string, dataType.bool, dataValue)
}
