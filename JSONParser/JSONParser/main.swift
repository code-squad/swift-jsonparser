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

print("분석할 JSON 데이터를 입력하세요.")
// 입력
let inputView = InputView()
let inputItems = inputView.readInput()
// 분석
let analyser : JSONAnalyser = JSONAnalyser()
let jsonData : JSONData = analyser.getJSONData(items: inputItems)
// 카운트
var typeCounter = TypeCounter()
typeCounter.countTypes(items: jsonData)
// 출력
let outputView = OutputView(typeCounter: typeCounter)
outputView.printResult()
