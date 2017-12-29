//
//  main.swift
//  JSONParser
//
//  Created by Jack (2017/12/19)
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

let outputView : OutputView = OutputView()
var userInput : String = ""
repeat {
    
    outputView.printMessages(.inputMessage)
    userInput = InputView().readInput()
    guard userInput != "q" else {
        outputView.printMessages(.exitMessage)
        continue
    }
    guard GrammarChecker().isValid(userInput: userInput) else {
        outputView.printMessages(.formatError)
        continue
    }

    let convertedData = DataFactory().generateData(userInput)
    let numbersOfData = DataCounter().countNumberOfData(convertedData)
    
    outputView.printResultOfData(numbersOfData)
    
} while(userInput != "q")
