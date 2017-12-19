//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//


let inputView = InputView()
let userInput = inputView.askUserInput()

let parser = Parser()
let convertedValues = parser.matchValuesToJSONType(userInput)

let counter = ValueCounter(targetToCount: convertedValues)
let countInfo = counter.makeCountInfo()

let outputView = OutputView()
outputView.showResult(countInfo)


