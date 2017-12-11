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
guard let tokenValue: JsonScanner.regex = token?[0].id else {
    throw JsonScanner.JsonError.invalidJsonPattern
}
if tokenValue == JsonScanner.regex.STARTSQUAREBRACKET {
    firstObject = ArrayJsonParser()
}else if tokenValue == JsonScanner.regex.STARTCURLYBRACKET {
    firstObject = ObjectJsonParser()
}else {
    print("JSON 데이터가 아님")
}
firstObject?.checkJsonSyntax(token: token!, stack: jsonStack)

// counting json data
var jsonTypeCounter = JsonTypeCounter()
let data = try jsonTypeCounter.countDataType(stack: jsonStack, kindOf: (firstObject?.type)!)

// outputview
OutputView.printDataInfo(data: data)

