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
        let lexer = Lexer(jsonFormat)
        let tokens = try lexer.getToken()
        let parse = try Paser(tokens).parse()
        let jsonData:JSONData = try Json.get(parse)
        OutputView.resultShow(jsonData)
        
    }catch let e as JSONPaserErorr {
        OutputView.errorMessage(of: e)
    }
}

try main()
