//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main() {
    
    guard let input = InputView.readInput(Question.askJSONData) else {
        return
    }
    
    let lexer: Lexer = Lexer(input: input)
}

main()
