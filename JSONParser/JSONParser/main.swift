//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

InputView.printInstruction()
let input = InputView.read()

let tokens = Tokenizer.execute(using: input)
let parsedValues: [JSONValue] = Parser.parse(tokens)

