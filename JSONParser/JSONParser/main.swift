//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

struct Main {
    static func start(){
        guard let input = InputView.read() else { return }
        let jsonParser = JSONParser(elements: input)
        OutputView.display(json: input, strings: jsonParser.strings, integers: jsonParser.integers, booleans: jsonParser.booleans)
    }
}

Main.start()
