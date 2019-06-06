//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

let input = try InputView.ask(for: .request)
let tokenizedInput = try JSONTokenizer.tokenize(data: input)

let analyzedInput = try JSONLexer.analyze(data: tokenizedInput)

let parsedInput = try analyzedInput.map {
   try JSONParser.parseValue(data: $0)
}

print(parsedInput)
