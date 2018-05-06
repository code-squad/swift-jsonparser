//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main(_ argc: Int32, _ arguments: [String]) {
    
    do {
        let input: String = argc >= 2 ? try InputView.readInputFromFile(arguments[1]) : try InputView.readInput(Question.askJSONData)
        let lexer: Lexer = Lexer(input: input)
        let tokenData: TokenData = try lexer.lex()
        let parser: Parser = Parser(tokenData: tokenData)
        let jsonData: JSONData = try parser.parse()
        if let jsonData = jsonData as? JSONPrintable {
            OutputView.printNumberOfJSONData(jsonData)
            switch argc {
            case 1:
                OutputView.printJSONData(jsonData)
            case 2:
                try OutputView.writeJSONData(jsonData, fileName: nil)
            case 3:
                try OutputView.writeJSONData(jsonData, fileName: arguments[2])
            default:
                throw OutputView.Error.invalidNumberOfArguments
            }
        }
    } catch let error as Lexer.Error {
        print(error.errorMessage)
    } catch let error as Parser.Error {
        print(error.errorMessage)
    } catch let error as GrammarChecker.Error {
        print(error.errorMessage)
    } catch let error as InputView.Error {
        print(error.errorMessage)
    } catch let error as OutputView.Error {
        print(error.errorMessage)
    } catch {
        fatalError("Unexpected Error")
    }
}

main(CommandLine.argc, CommandLine.arguments)
