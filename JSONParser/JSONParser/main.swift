//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//


let inputView = InputView()
let outputView = OutputView()
let producer = ObjectProducer()
let counter = ObjectCounter()


let userInput = inputView.askUserInput()
let stringValues = producer.makeObject(userInput)
let countInfo = counter.checkTypeOfValues(stringValues)
outputView.showResult(countInfo)
