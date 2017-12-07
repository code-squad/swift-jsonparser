//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//


let inputView = InputView()
let producer = ValueProducer()
let valueCounter = ValueCounter()
let outputView = OutputView()


let userInput = inputView.askUserInput()
let stringValues = producer.makeInputIntoList(userInput)
let countInfo = valueCounter.checkTypeOfValue(stringValues)
outputView.showResult(countInfo)

