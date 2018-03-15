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
    let inputData = InputView().separateByComma(input)
    let data = InputView().dropBrackets(inputData)
    let dataValue = InputView().removeWhiteSpace(data)
    let dataType = InputView().makeDataArray(dataValue)
    ResultView().resultMessage(dataType.number, dataType.string, dataType.bool, dataValue)
}


