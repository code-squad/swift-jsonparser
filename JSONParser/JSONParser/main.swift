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
var token: [Token]? = nil

//scanner
var jsonScanner = JsonScanner()
do {
    try token = jsonScanner.scanOfJsonValue(jsonValue: jsonValue)
}catch JsonScanner.JsonError.invalidJsonPattern {
    print("Json invalid error")
}

// json parser (checking json syntax)
var jsonStack = JsonStack()
var firstObject: FirstObject? = nil
if token![0].id == JsonScanner.regex.STARTSQUAREBRACKET {
    firstObject = ArrayJsonParser()
}else if token![0].id == JsonScanner.regex.STARTCURLYBRACKET {
        firstObject = ObjectJsonParser()
}else {
    print("객체도 배열도 아님", token![0].id)
}
firstObject?.checkJsonSyntax(token: token!, stack: jsonStack)

// counting json data
var jsonTypeCounter = JsonTypeCounter()
let data = try jsonTypeCounter.countDataType(stack: jsonStack, kindOf: (firstObject?.type)!)

// outputview
var outputView = OutputView()
outputView.printDataInfo(data: data)

