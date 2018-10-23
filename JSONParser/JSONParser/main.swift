//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

struct Main {
    static func run() {
        let jsonString = InputView.readInput()
        guard let jsonArray: [Any?] = JSONParser.makeJSONArray(from: jsonString) else {
            OutputView.notifyIssue()
            return
        }
        OutputView.showTypeCountOf(JSON: jsonArray)
    }
}

Main.run()
