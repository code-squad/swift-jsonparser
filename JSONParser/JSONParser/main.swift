//
//  main.swift
//  JSONParser
//
//  Created by Jack (2017/12/19)
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

var runJsonParser : Bool = true
mainLoop : while runJsonParser == true {
    let inputView : InputView = InputView()
    let dataFactory : DataFactory = DataFactory()
    
    let userInput = inputView.readInput()
    guard userInput != "q" else { break }
    guard inputView.isValid(userInput) == true else { continue }
    let userData = inputView.sliceMarks(userInput)
    
    let resultOfparsing = dataFactory.seperateData(userData)
    
    OutputView().printResult(resultOfparsing)
}
