//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

struct Main {
    static func start(){
        guard let input = InputView.read() else { return }
        let tokens = Tokenizer(target: input).parse()
        if let values = Formatter(tokens: tokens).isValidTokens(){
            OutputView.display(values)
        }else {
            print("지원하지 않는 형식이 포함되어 있습니다.")
        }
//        JSONParser.parsing(target: input)
//        let result = JSONParser.result(from: input)
//        OutputView.display(from: result)
    }
}

Main.start()
