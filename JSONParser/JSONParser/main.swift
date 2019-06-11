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
    let input = try InputView.readInput(of: RequestMassage.requestJSON)
    let json = try Validator.JSONArrayformatValidator(input: input)
    let convertedJSONToArray = Converter.convertToArray(JSON: json)
    let parsedData = try dataParser.makeParsingData(data: convertedJSONToArray)
    OutputView.printResult(countNumber: parsedData)
} catch let error as JSONError {
    print(error.message)
}

