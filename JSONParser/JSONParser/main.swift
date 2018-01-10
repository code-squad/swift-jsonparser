//
//  main.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 11..
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

while true {
    var unanalyzedValue: String = ElementOfString.emptyString.description
    let url = FileManager.default.homeDirectoryForCurrentUser
    if CommandLine.arguments.count <= 1 {
        unanalyzedValue = InputView.readFromConsole()
        guard unanalyzedValue != Message.ofEndingProgram.description else { break }
        guard let analyzedValue = Analyzer.makeConsoleAnalyzedResult(unanalyzedValue: unanalyzedValue) else { continue }
        OutputView.makeConsoleResult(analyzedValue)
    } else {
        guard let jsonFile = InputView.makeInOutFile() else { break }
        unanalyzedValue = InputView.readFromFile(in: jsonFile.0, url: url)
        guard let analyzedValue = Analyzer.makeFileAnalyzedResult(unanalyzedValue: unanalyzedValue) else { break }
        guard OutputView.writeOutputFile(analyzedValue, outputFile: jsonFile.1, directory: url) else { break }
        break
    }
}

