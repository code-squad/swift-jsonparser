//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//


let inputView = InputView()
let userInput = inputView.askUserInput()

let targetFactory = ParsingTargetFactory()
let targetString = targetFactory.convertTargetToString(userInput)

let targetSetter = JSONDataFactory(targetString)
let parsedData = targetSetter.setTargetType()

let counter = ValueCounter(parsedData)
let countInfo = counter.makeCountInfo()

let outputView = OutputView()
outputView.showResult(countInfo)


