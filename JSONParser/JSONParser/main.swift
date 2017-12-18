//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//


let inputView = InputView()
let userInput = inputView.askUserInput()
let parseTargetFactory = ParseTargetFactory()
let parseTarget = parseTargetFactory.decideInputType(userInput)

let targetFactory = JSONDataFactory()
let convertedValue = targetFactory.makeConvertedData(parseTarget.makeMyType())
let counter = ValueCounter(targetToCount: convertedValue)
let countInfo = counter.makeCountInfo()

let outputView = OutputView()
outputView.showResult(countInfo)

