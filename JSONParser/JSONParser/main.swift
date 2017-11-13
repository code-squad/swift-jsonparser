//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

typealias JSONData = Array<Any>
typealias JSONObject = Dictionary<String, Any>

// 입력
let inputView : InputView = InputView()
let inputItems : Array<String> = inputView.readInput()
// 분석
let jsonData : JSONData = JSONAnalyser.getJSONData(items: inputItems)
// 카운트
let typeCounter : TypeCounter = TypeCounter.init(items: jsonData)
// 출력
let outputView : OutputView = OutputView.init(typeCounter: typeCounter)
outputView.printResult()
