//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

    let message = "분석할 JSON 데이터를 입력하세요."
    let input = InputView().readInput(message)
    let inputData = InputView().makeDataArray(input)
    let dataCount = InputView().countData(inputData)
    ResultView().resultMessage(dataCount.number, dataCount.string, dataCount.bool, dataArray: inputData)



