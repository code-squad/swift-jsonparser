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
        let temp = InputView.read()
        if temp == "quit" { break }
        let temp2 = try Analyzer().makeTypeCounting(temp)
        OutputView.printResult(temp2)
    } catch let error as Analyzer.ErrorMessage {
        print (error.rawValue)
    }
    
}
