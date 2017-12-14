//
//  main.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 11..
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

while true {
    do {
        let unanalyzedValue = InputView.read()
        if unanalyzedValue == "quit" { break }
        let validString = try SyntaxChecker.makeValidString(values: unanalyzedValue)
        let countedValue =  Analyzer.makeCountedTypeInstance(validString)
        OutputView.printResult(countedValue)
    } catch let error as SyntaxChecker.ErrorMessage {
        print (error.rawValue)
    }
    
}
