//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

//inputview
var inputView = InputView()
let jsonValue = inputView.readInput()

// jsonParser
var jsonParser = JsonParser()
let jsonData = try jsonParser.makeJsonData(jsonValue: jsonValue)

// counting json data
var jsonTypeCounter = JsonTypeCounter()
let data = try jsonTypeCounter.findTypeOfData(jsonData: jsonData as! FirstClassObject)

// outputview
var outputView = OutputView()
outputView.printDataInfo(data: data.dataInfo)
outputView.printJsonString(jsonData: data.jsonData)



