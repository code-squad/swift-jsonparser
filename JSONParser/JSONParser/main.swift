//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main() {
    // 각 객체의 인스턴스를 생성
    let grammarChecker = GrammarChecker()
    let jsonParser = JSONParser()
    let outputView = OutputView()
    
    // 입력을 받고, 에러를 처리
    var input = InputView.getInput(ment: "분석할 JSON 데이터를 입력하세요.")
    var error = grammarChecker.textErrorCheck(of: input)
    
    while error != .noError {
        input = InputView.getInput(ment: "\(error.rawValue)")
        error = grammarChecker.textErrorCheck(of: input)
    }
    
    // 에러 처리된 입력을 문자열 변환하고 출력
    guard let jsonData = jsonParser.parse(from: input) else { return }
    outputView.printResult(by: jsonData)
}

main()
