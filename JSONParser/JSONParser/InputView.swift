//
//  InputView.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 4..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    
    enum InputError: Error, CustomStringConvertible {
        case noFile
        case voidFile
        case voidInput
        
        var description: String {
            switch self {
            case .noFile:
                return "입력하신 이름의 파일이 없습니다."
            case .voidFile:
                return "파일에 분석할 내용이 없습니다."
            case .voidInput:
                return "입력한 문자열이 없습니다."
            }
        }
    }
    
    enum InputType {
        case console
        case file
    }
    
    
    func readCommandLine(_ arguments: [String]) throws -> (input: String, output: String) {
        var cmdInput = ""
        var cmdOutput = ""
        
        if arguments.count < 2 {
            let userInput = askUserInput(message: "분석할 JSON 문자열을 입력하세요.")
            guard let inputSting = userInput else {
                throw InputError.voidInput
            }
            cmdInput = inputSting
            return (input:cmdInput, output:cmdOutput)
        }
        if arguments.count == 2 {
            cmdInput = try readFile(String(arguments[1]))
            cmdOutput = "default.json"
            return (input:cmdInput, output:cmdOutput)
        }
        if arguments.count > 2 {
            cmdInput = try readFile(String(arguments[1]))
            cmdOutput = arguments[2]
            return (input:cmdInput, output:cmdOutput)
        }
        
        return (input:cmdInput, output:cmdOutput)
    }
    
    
    func readFile(_ file: String) throws -> String {
        var text = ""
        
        let inputFile = file.split(separator: ".")
        let fileName = String(inputFile[0])
        let fileType = String(inputFile[1])
        let path = Bundle.main.path(forResource: fileName, ofType: fileType)
        guard let filePath = path else {
            throw InputError.noFile
        }
        text = try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
        return text
    }
    
    func askUserInput(message: String) -> String? {
        print(message)
        let userInput = readLine()
        return userInput
    }
    
}

