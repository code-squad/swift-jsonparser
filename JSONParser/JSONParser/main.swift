//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation


InputView.printInstruction()

var parsedValues: [JSONValue]!

do {
    let input = try InputView.read()
    let tokens = try Tokenizer.execute(using: input)
    parsedValues = try Parser.parse(tokens)
} catch let e as JSONParserError {
    print(e.message)
}

if parsedValues != nil {
    OutputView.printJSONDescription(of: parsedValues)
}


