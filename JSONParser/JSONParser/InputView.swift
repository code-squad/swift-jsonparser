//
//  InputView.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 4..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    
    func readFile() -> String {
        var text = ""
        let arguments = CommandLine.arguments
        var inputFileName = ""
        var inputFileType = ""
        
        if arguments.count < 2 {
            text = askUserInput() // optional
            return text
        }
        if arguments.count >= 2 {
            print("test",arguments[1])

            let inputFile = arguments[1].split(separator: ".")
            inputFileName = String(inputFile[0])
            inputFileType = String(inputFile[1])
            let path = Bundle.main.path(forResource: inputFileName, ofType: inputFileType)
            text = try! String(contentsOfFile:path!, encoding: String.Encoding.utf8)
        }
        return text
    }
    
    func askUserInput () -> String {
        print("분석할 JSON 데이터를 입력하세요.")
        let userInput = readLine()
        let input = userInput ?? ""
        if input == "" {
            return askUserInput()
        }
        return input
    }
}

