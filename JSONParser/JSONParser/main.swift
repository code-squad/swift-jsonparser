//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

let userInput = InputView.readPrompt(for: "분석할 JSON 데이터를 입력하세요.")

let tokens = Tokenizer.tokenize(from: userInput)
let converter = Converter()
let parser = Parser.init(converter: converter)
let jsonDatas = parser.parse(tokens: tokens)

OutputView.printDescription(of: jsonDatas)
