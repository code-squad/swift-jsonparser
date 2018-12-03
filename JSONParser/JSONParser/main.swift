//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main() {
    let grammarChecker = GrammarChecker()
//    let jsonParser = JSONParser()
    let outputView = OutputView()
    var input : String
    var inputState : FormState
    
    repeat {
        input = InputView.UserInput(message: "분석할 JSON 문자열을 입력하세요.")
        inputState = grammarChecker.checkJSONForm(input)
        outputView.printErrorState(inputState)
    } while inputState != .userInputForm && inputState != .fileInputForm
    
    DistinguishOrder.excuteOrder(of: inputState, in: input)
}

main()


