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
        do {
            let input = try InputView.read()
            let tokens = try Tokenizer.parse(input)
            let values = try Formatter.generateJSON(from: tokens)
            OutputView.display(values)
        }catch JSONParserError.invalidFormat {
            OutputView.display(.invalidFormat)
        }catch JSONParserError.invalidInput {
            OutputView.display(.invalidInput)
        }catch {
            OutputView.display(.unexpected)
        }
    }
}

Main.start()
