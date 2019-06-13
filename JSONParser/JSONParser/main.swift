//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

do{
    var dataParser = DataParsingFactory()
    let input = try InputView.readInput(massage: Massage.requestJSON)
    let JSON = try Validator.JSONArrayformat(input: input)
    let parsedData = try dataParser.makeParsingData(data: JSON)
    OutputView.printResult(countNumber: parsedData)
} catch let error as JSONError {
    print(error.message)
}

