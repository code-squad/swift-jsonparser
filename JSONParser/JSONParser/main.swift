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
        if isJSONPattern {
            let tokens = try Tokenizer.execute(jsonData: input)
            var jsonParser = Parser(tokens: tokens)
            let parsedValue = try jsonParser.parse()
            try OutputView.printJSONDescription(of: parsedValue)
        } else {
            print("지원하지 않는 형식입니다.")
        }
    } catch let error as JSONError {
        print(error.message)
        return
    } catch {
        print("Other Unexpected Error")
        return
    }
}

main()

