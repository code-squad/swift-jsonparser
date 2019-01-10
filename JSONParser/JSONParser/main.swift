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

    guard CheckInput.isInputable(input: input) else {
        print(ErrorMessage.reEntered.description)
        return
    }

    let splitInput = InputView.splitInput(input)
    let json = JSONData.makeJSON(from: splitInput)
    OutputView.printData(in: json, from: splitInput)
}

while true {
    main()
}

