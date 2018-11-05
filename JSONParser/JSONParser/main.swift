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
        guard let file = InputView.readArgument(atIndex: .inputFile) else {
            OutputView.notifyIssue(of: .noInputFile)
            return
        }
        guard let jsonString = InputView.readContents(from: file) else { return }
        guard let jsonDataForm: JSONDataForm = JSONParser.parse(jsonString) else {
            OutputView.notifyIssue(of: .invalidForm)
            return
        }
        OutputView.writeJSONPrettyPrinted(of: jsonDataForm)
    }
}

Main.run()
