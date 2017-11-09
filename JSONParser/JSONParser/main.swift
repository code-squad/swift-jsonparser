//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

// 단순한 JSON 배열(array) 문자열을 입력하면 내부 요소들을 분석해서 배열로 저장하도록 구현한다.
while(true) {
    // 입력 받기
    guard let jsonString = InputView.read() else { break }
    do {
        // json string 을 json object 로 변환
        let analyzedArray = try JSONAnalyzer.makeObject(with: jsonString)
        
        // 분석한 결과 출력
        OutputView.printJSON(analyzedArray)
        
    } catch GrammarChecker.FormatError.notFormatted{
        print(GrammarChecker.FormatError.notFormatted.rawValue)
    } catch GrammarChecker.FormatError.invalidDataType{
        print(GrammarChecker.FormatError.invalidDataType.rawValue)
    }
}

