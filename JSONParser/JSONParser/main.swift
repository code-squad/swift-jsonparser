//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func parseIntoJSON(from input: String) -> JSONValue? {
    do {
        let tokens = try Tokenizer.execute(jsonData: input)
        var jsonParser = Parser(tokens: tokens)
        let parsedValue = try jsonParser.parse()
        return parsedValue
    } catch let error as JSONError {
        OutputView.printMessage(of: error)
        return nil
    } catch {
        OutputView.printUnexpectedErrorMessage()
        return nil
    }
}

func main() {
    InputView.printInstruction()
    let input = InputView.read()
    guard GrammarChecker.check(input: input), let jsonData = parseIntoJSON(from: input) else {
        OutputView.noticeUnsupportedPattern()
        return
    }
    OutputView.printJSONDescription(of: jsonData)
}

main()

