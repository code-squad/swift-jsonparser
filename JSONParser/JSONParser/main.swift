//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//


let inputView = InputView()
let userInput = inputView.askUserInput()

let conductor = TypeConductor(userInput)
let parsingTarget = conductor.decideInputType()

let targetFactory = JSONDataFactory()
let convertedValue = targetFactory.convertValues(parsingTarget)
let counter = ValueCounter(targetToCount: convertedValue)
let countInfo = counter.makeCountInfo()

let outputView = OutputView()
outputView.showResult(countInfo)

