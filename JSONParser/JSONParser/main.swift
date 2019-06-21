//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

do{
    let input = try InputView.readInput(massage: .requestJSON)
    var parser = Parser()
    let parsedData = try parser.makeParsingData(input: input)
    OutputView.printResult(data: parsedData)
} catch let error as JSONError {
    print(error.message)
}

