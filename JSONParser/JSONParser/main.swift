//
//  main.swift
//  JSONParser
//
//  Created by Elena on 20/12/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

let userInputData = InputView.getUserString()

let result = Parser.isDivideData(from: userInputData)
print(result)
