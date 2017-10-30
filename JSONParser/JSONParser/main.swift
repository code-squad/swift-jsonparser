//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

let inputView = InputView()

while(true) {
    do {
        // 단순한 JSON 배열(array) 문자열을 입력하면 내부 요소들을 분석해서 배열로 저장하도록 구현한다.
        
        // 입력 받기
        guard let jsonString = try inputView.readInput() else { break }
        
        // json string 을 json object 로 변환
        let analyzedArray = try JSONAnalyzer.makeObject(with: jsonString)
        
        // 분석한 결과 출력
        OutputView.printAnalyzeResult(analyzedArray)
        
    } catch InputError.invalidInput{
        print("입력 값이 유효하지 않습니다.")
    }
}

