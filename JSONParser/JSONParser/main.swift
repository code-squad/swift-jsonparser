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
    let jsonParser = JSONParser()
    var input : String
    var inputState : FormState
    let argumentState = ExecutorByArgument.checkCommandLineState()
    
    repeat {
        input = ExecutorByArgument.inputByCommanLine(of : argumentState)
        inputState = grammarChecker.checkJSONForm(input)
        if argumentState == nil { OutputView.printErrorState(inputState) }              // CommandLine으로 Argument가 안들어온 경우만 콘솔에 에러 상황 출력
    } while inputState != .rightForm && argumentState == nil
    
    let jsonToSwift = jsonParser.jsonParser(dataToConvert: input)
    ExecutorByArgument.outputByCommandLine(of: argumentState, with: jsonToSwift)
}

main()


