//
//  main.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 11..
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

while true {
    do {
        var unanalyzedValue: String = ElementOfString.emptyString.description
        let url = FileManager.default.homeDirectoryForCurrentUser
        if CommandLine.arguments.count <= 1 {
            guard let unAnalyzedValue = InputView.readFromConsole() else { break }
            guard let analyzedValue = Analyzer.makeConsoleAnalyzedResult(unanalyzedValue: unAnalyzedValue) else { continue }
            OutputView.makeConsoleResult(analyzedValue)
        } else {
            guard let jsonFile = InputView.makeInOutFile() else { break }
            unanalyzedValue = try InputView.readFromFile(in: jsonFile.0, url: url)
            guard let analyzedValue = Analyzer.makeFileAnalyzedResult(unanalyzedValue: unanalyzedValue) else { continue }
            try OutputView.writeOutputFile(analyzedValue, outputFile: jsonFile.1, directory: url)
            break
        }
    } catch Message.ofFailedProcessingFile {
        print (Message.ofFailedProcessingFile)
        break
    } catch let error as Message {
        print (error)
    }
}

