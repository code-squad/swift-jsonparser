//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main() {
    InputView.printInstruction()
    do {
        let input = try InputView.read()
        let isJSONPattern = try GrammarChecker.check(input: input)
        if !isJSONPattern {
            throw GrammarCheckerError.matchNoPattern
        }
        let tokens = try Tokenizer.execute(jsonData: input)
        var jsonParser = Parser(tokens: tokens)
        let parsedValue = try jsonParser.parse()
        try OutputView.printJSONDescription(of: parsedValue)
    } catch let e as JSONError {
        print(e.message)
        return
    } catch {
        print("Other Unexpected Error")
        return
    }
}

main()

