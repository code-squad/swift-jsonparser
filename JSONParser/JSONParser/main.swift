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
        let jsonFormat = try InputView.readInput()
        let tokens = try Lexer(jsonFormat).getToken()
        let parse = try Parser(tokens).parse()
        OutputView.resultShow(parse)
        
    }catch let e as JSONPaserErorr {
        OutputView.errorMessage(of: e)
    }
}

try main()
