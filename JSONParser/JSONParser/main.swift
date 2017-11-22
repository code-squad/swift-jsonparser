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
                outputView.printJSONAnalysis(jsonData: try parser.makeJSONData(rawJSONData))
                repeatCondition = false
            }
        } catch JSONParser.ErrorCode.invalidJSONStandard {
            outputView.printErrorMsg(errorCode: .invalidJSONStandard)
        } catch JSONParser.ErrorCode.invalidInputString {
            outputView.printErrorMsg(errorCode: .invalidInputString)
        } catch JSONParser.ErrorCode.invalidPatten {
            outputView.printErrorMsg(errorCode: .invalidPatten)
        } catch {
            return
        }
    }
    
}

executeJSONParser()
