//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func run() {
    let input: String
    let tokens: [Token]
    let jsonValue: JSONValue
    
    do {
        input = try InputView.readJSONData()
        guard GrammarChecker.isValidFormat(input, rule: JSONValidationRule.isValid) else {
            print(ErrorMessage.validationFailed)
            return
        }
    } catch let error as InputView.Error {
        print(error.localizedDescription)
        return
    } catch {
        print("\(ErrorMessage.unexpectedError): \(error)")
        return
    }
    
    do {
        let characters = Array(input)
        let stringReader = Reader(elements: characters)
        var lexer = Lexer(stringReader: stringReader)
        tokens = try lexer.tokenize()
    } catch let error as Lexer.Error {
        print(error.localizedDescription)
        return
    } catch {
        print("\(ErrorMessage.unexpectedError): \(error)")
        return
    }
    
    do {
        let tokenReader = Reader(elements: tokens)
        var parser = Parser(tokenReader: tokenReader)
        jsonValue = try parser.parseJSONValue()
    } catch let error as Parser.Error {
        print(error.localizedDescription)
        return
    } catch {
        print("\(ErrorMessage.unexpectedError): \(error)")
        return
    }
    
    OutputView.printJSONValue(jsonValue)
}

run()
