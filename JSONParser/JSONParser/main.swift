//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    static func run() {
        let jsonString = InputView.readInput()
        let stringArray = JSONGenerator.stringArray(jsonString)
        OutputView.showTypeCountOf(JSON: stringArray)
    }
}

JSONParser.run()
