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
let targetString = targetFactory.makeParsingTarget(userInput)

let typeIdentifier = TypeIdentifier()
let parsedData = typeIdentifier.matchType(targetString)

let counter = ValueCounter(parsedData)
let countingInfo = counter.countingValues()

let outputView = OutputView()
outputView.showResult(countingInfo)
