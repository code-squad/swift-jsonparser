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

var inputValue : String = ""
let grammarChecker : GrammarChecker = GrammarChecker()
var flag : Bool = false
while !flag {
    // 입력
    print("분석할 JSON 데이터를 입력하세요.")
    inputValue = InputView.readInput()
    do {
        // 패턴검사
        try grammarChecker.isJSONPattern(target: inputValue)
        flag = true
    } catch GrammarChecker.ErrorMessage.notJSONPattern {
        print("지원하지 않는 형식을 포함하고 있습니다.")
    } catch {
        print("입력값이 정상적이지 않습니다.")
    }
}
// 분석
let jsonAnalyser = JSONAnalyser.init(grammarChecker: grammarChecker)
let jsonData = jsonAnalyser.getJSONData(inputValue: inputValue)
// 카운트
let typeCounter = TypeCounter.init(jsonData: jsonData)
// 출력
let outputView = OutputView.init(typeCounter: typeCounter)
outputView.printResult()
