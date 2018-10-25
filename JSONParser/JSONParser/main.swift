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
        guard let jsonDataForm: JSONDataForm = JSONParser.parse(jsonString) else {
            OutputView.notifyIssue()
            return
        }
        OutputView.showTypeCount(of: jsonDataForm)
    }
}

Main.run()
