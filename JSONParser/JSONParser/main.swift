//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func analyzeJson(to inputValue:String?) -> Bool {
    // 입력값 비어있는지 확인
    guard let input = InputView.isEmpty(to: inputValue) else { return true }

    // 예외처리
    do {
        try GrammarChecker.isValidate(to: input)
    } catch JsonError.unSupportedArrayPattern {
        OutputView.printErrorMessage(error: JsonError.unSupportedArrayPattern)
        return true
    } catch JsonError.unSupportedObjectPattern {
        OutputView.printErrorMessage(error: JsonError.unSupportedObjectPattern)
        return true
    } catch {
        // 해당 부분은 Default 형식으로 추가해주도록 체크되고 있습니다.
        OutputView.printErrorMessage(error: JsonError.unknown)
        return true
    }
    
    // 분석하기
    let json = Analysis.analysisJson(to: input)

    // 객체 정보 출력하기
    OutputView.printJson(from: json)
    
    // 객체 파일 생성
    if let fileName = OutputFile.name {
        OutputView.writeFile(outputFile: fileName, from: json)
    }
    
    return false
}

var analyze = true
while analyze {
    // 파일 or 프로젝트 내부 실행 분기
    let arguments = CommandLine.arguments
    var inputValue:String? = ""
    
    if arguments.count >= 2 {
        do {
            try inputValue = InputView.readFile(inputFile: arguments[1])
            OutputFile.name = arguments.count > 2 ? arguments[2] : "output.json"
            analyze = analyzeJson(to: inputValue)
        } catch JsonError.fileNotFound {
            OutputView.printErrorMessage(error: JsonError.fileNotFound)
            analyze = false
        }
    } else {
        inputValue = InputView.readInput()
        analyze = analyzeJson(to: inputValue)
    }
}
