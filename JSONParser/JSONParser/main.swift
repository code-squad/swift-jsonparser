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
var inputItems : Array<String> = []
while inputItems.count == 0 {
    do {
        print("분석할 JSON 데이터를 입력하세요.")
        inputItems = try inputView.readInput()
    } catch GrammarChecker.ErrorMessage.notJSONPattern {
        print("지원하지 않는 형식을 포함하고 있습니다.")
    } catch {
        print("입력이 정상적이지 않습니다.")
    }
}
// 분석
let jsonData : JSONData = JSONAnalyser.getJSONData(items: inputItems)
// 카운트
let typeCounter : TypeCounter = TypeCounter.init(items: jsonData)
// 출력
let outputView : OutputView = OutputView.init(typeCounter: typeCounter)
outputView.printResult()
