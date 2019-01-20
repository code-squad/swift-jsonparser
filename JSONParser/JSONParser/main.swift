//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main() {
    let input = InputView.readInput() 

    guard CheckInput.validInput(userInput: input) else {
        print(ErrorMessage.reEntered.description)
        return
    }
    
    let splitInput = InputView.splitInput(input)
    
    let regex = RegularExpression.makeJsonData(split: splitInput) // [10, "jk", 4, "314", 99, "crong", false]
    OutputView.printData(in: regex, from: splitInput)
}

while true {
    main()
}

