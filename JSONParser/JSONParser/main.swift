//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation


func analyzeJson() -> Bool {
    // 입력받기
    let inputValue = InputView.readInput()
    // 입력값 비어있는지 확인
    guard var input = InputView.isEmpty(to: inputValue) else { return true }

    // 배열 형식 검사
    guard input.unsupportedArrayTypes() else {
        print("지원하지 않는 형식을 포함하고 있습니다.")
        return true
    }
    
    // 객체 형식 검사
    guard input.unsupportedObjectTypes() else {
        print("지원하지 않는 형식을 포함하고 있습니다.")
        return true
    }
    
    // {} or [] 쌍 확인
    guard GrammarChecker.checkPair(to: input) else {
        print("{} or [] 개수가 일치하지 않습니다. 다시 입력하세요.")
        return true
    }
    
    // 패턴 확인
    guard GrammarChecker.checkPattern(to: input) else {
        print("패턴이 일치하지 않습니다. 다시 입력하세요.")
        return true
    }
    
    // 분석하기 (분석하기 전에 지원범위 확인 or 분석이후 지원범위 확인)
    let json = Analysis.analysisJson(to: input)
    // 출력하기
    OutputView.printJson(to: json)
    return false
}

var analyze = true
while analyze {
    analyze = analyzeJson()
}
