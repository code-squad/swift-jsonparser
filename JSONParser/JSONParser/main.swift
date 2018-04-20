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
    var jsonData:JSONData
    do {
        let jsonFormat = try InputView.readInput()
        let lexer = Lexer(jsonFormat)
        let tokens = try lexer.getToken()
        jsonData = try Paser(tokens).parse()
        
        OutputView.resultShow(jsonData)
        
    }catch let e as JSONPaserErorr {
        OutputView.errorMessage(of: e)
    }
    
    
}

try main()
