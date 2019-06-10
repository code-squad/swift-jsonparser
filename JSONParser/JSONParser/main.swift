//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

var counter = Counter()

do{
    let json = try InputView.readInput(of: RequestMassage.requestJSON)
    let convertedJSONToArray = converter.convertToArray(JSON: json)
    let CountNumber = try counter.dataTypeCounter(convertedJSONToArray: convertedJSONToArray)
    OutputView.printResult(countNumber: CountNumber)
} catch let error as JSONError {
    print(error.message)
}

