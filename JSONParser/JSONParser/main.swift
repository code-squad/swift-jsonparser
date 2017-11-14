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
        do {
            if let rawJSONData = inputView.read() {
                let checkedJSON = try parser.check(rawJSONData)
                outputView.printJSONAnalysis(jsonData: parser.makeJSONData(checkedJSON))
                repeatCondition = false
            }
        } catch ErrorCode.invalidJSONStandard {
            outputView.printErrorMsg(errorCode: .invalidJSONStandard)
        } catch ErrorCode.invalidInputString {
            outputView.printErrorMsg(errorCode: .invalidInputString)
        } catch {
            return
        }
    }

}

executeJSONParser()
