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
        var unanalyzedValue: String = ""
        // Mark : argument.count에 따른 인풋 분기
        if CommandLine.arguments.count <= 1 {
            unanalyzedValue = try InputView.readFromConsole()
        }
        
        if CommandLine.arguments.count >= 2 {
            let jsonFile = try ProcessInfo.processInfo.arguments.makeFileIOPath()
            unanalyzedValue = try InputView.readFromFile(in: jsonFile.0)
        }
        
        let validString = try GrammerChecker.makeValidString(values: unanalyzedValue)
        let analyzedValue = Analyzer.makeAnalyzedTypeInstance(validString)
        
         // Mark : argument.count에 따른 아웃풋 분기
        if CommandLine.arguments.count <= 1 {
            OutputView.makeConsolResult(analyzedValue)
        }
        if CommandLine.arguments.count >= 2 {
            try OutputView.writeOutputFile(analyzedValue, CommandLine.arguments[1])
            throw Message.ofEndingProgram
        }
    } catch Message.ofEndingProgram {
        break
    } catch Message.ofFailedProcessingFile {
        print (Message.ofFailedProcessingFile.description)
        break
    } catch let error as Message {
        print (error)
    }
}

