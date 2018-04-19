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
    let grammarChecker = GrammarChecker()
    guard grammarChecker.isValidFirstString(inputData) && grammarChecker.isValidLastString(inputData) else {
        print("지원하지 않는 형식을 포함하고 있습니다.")
        continue }
    let myJsonParser = MyJsonParser()
    guard let jsonData = myJsonParser.checkBrackets(inputData) else { break }
    if jsonData is Dictionary<String, Any> {
        let dictionData = jsonData as! Dictionary<String,Any>
        guard grammarChecker.isValidOfDictionary(dictionData) else {
            print("지원하지 않는 형식을 포함하고 있습니다.")
            continue
        }
    }
    let myDataCount = jsonData.countJSONData()
    let resultView = ResultView()
    resultView.printMessage(myDataCount)
    let myData = jsonData.makeJSONData()
    resultView.printData(myData)
    
}




