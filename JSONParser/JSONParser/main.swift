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
            unanalyzedValue = try InputView.readFromConsole()
            let analyzedValue = try Analyzer.makeConsoleAnalyzedResult(unanalyzedValue: unanalyzedValue)
            OutputView.makeConsoleResult(analyzedValue)
        }
        
        if CommandLine.arguments.count >= 2 {
            let jsonFile = try CommandLine.arguments.makeInOutFile()
            unanalyzedValue = try InputView.readFromFile(in: jsonFile.0, url: url)
            let analyzedValue = try Analyzer.makeFileAnalyzedResult(unanalyzedValue: unanalyzedValue)
            try OutputView.writeOutputFile(analyzedValue, outputFile: jsonFile.1, directory: url)
            throw Message.ofEndingProgram
        }
    } catch Message.ofEndingProgram {
        break
    } catch Message.ofFailedProcessingFile {
        print (Message.ofFailedProcessingFile)
        break
    } catch let error as Message {
        print (error)
    }
}

