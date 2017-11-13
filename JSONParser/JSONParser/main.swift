//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func executeJSONParser() {
    let inputView = InputView()
    let outputView = OutputView()
    let parser = JSONParser()
    var repeatCondition = true
    
    while repeatCondition {
        print("분석할 JSON 데이터를 입력하세요.")
        if let rawJSONData = inputView.read() {
            outputView.printJSONAnalysis(jsonData: parser.makeJSONData(rawJSONData))
            repeatCondition = false
        }
    }
}

executeJSONParser()
