//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main() {
    let textValidator = TextValidator()
    let jsonParser = JSONParser()
    let outputView = OutputView()
    
    var input = InputView.getInput(ment: "분석할 JSON 데이터를 입력하세요.")
    var error = textValidator.textErrorCheck(of: input)
    
    while error != .noError {
        input = InputView.getInput(ment: "\(error.rawValue)")
        error = textValidator.textErrorCheck(of: input)
    }
    
    let counts = jsonParser.countsOfJSON(from: input)
    outputView.printResult(by: counts)
}

main()
