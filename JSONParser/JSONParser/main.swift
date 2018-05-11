//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

// MainController
func main() throws {
    OutputView.ask()
    do {
        let input = try InputView.readInput()
        let lex = Lexer(input).lex()
        let parse = try Parser(lex).parse()
        OutputView.showReuslt(parse)
        
    }catch let e as JsonError {
        OutputView.errorMessage(of: e)
    }
}

try main()

