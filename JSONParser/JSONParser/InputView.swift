//
//  InputView.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 4..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    
    func readCommandLine() -> (input: String, output: String) {
        let arguments = CommandLine.arguments
        var cmdInput = ""
        var cmdOutput = "default.json"
        
        if arguments.count < 2 {
            cmdInput = askUserInput()
            return (input:cmdInput,output:"")
        }
        if arguments.count == 2 {
            cmdInput = readFile(String(arguments[1]))
            return (input:cmdInput, output:cmdOutput)
        }
        
        if arguments.count > 2 {
            cmdInput = readFile(String(arguments[1]))
            cmdOutput = arguments[2]
            return (input:cmdInput, output:cmdOutput)
        }
        
        return (input:cmdInput, output:cmdOutput)
    }
    
    
    func readFile(_ file: String) -> String {
        var text = ""
        
        let inputFile = file.split(separator: ".")
        let fileName = String(inputFile[0])
        let fileType = String(inputFile[1])
        let path = Bundle.main.path(forResource: fileName, ofType: fileType)
        text = try! String(contentsOfFile:path!, encoding: String.Encoding.utf8)
        
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

