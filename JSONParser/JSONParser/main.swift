//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main() {
    guard let input = InputView.readInput(Question.askJSONData), !input.isEmpty else {
        return
    }
    
    do {
        let lexer: Lexer = Lexer(input: input)
        let tokenData: TokenData = try lexer.lex()
        let parser: Parser = Parser(tokenData: tokenData)
        let jsonData: JSONData = try parser.parse()
        if let jsonData = jsonData as? JSONPrintable {
            OutputView.printJSONData(jsonData)
        }
    } catch let error as Lexer.Error {
        print(error.errorMessage)
    } catch let error as Parser.Error {
        print(error.errorMessage)
    } catch let error as GrammarChecker.Error {
        print(error.errorMessage)
    } catch {
        fatalError("Unexpected Error")
    }
}

main()
