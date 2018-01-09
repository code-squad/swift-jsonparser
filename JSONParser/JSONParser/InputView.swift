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
    
    func readCommandLine(_ arguments: [String]) throws -> (contents: String, outputPath: String, type: InputType) {
        let fileManager = FileManager.default
        let currentDirectory = fileManager.currentDirectoryPath + "/"

        if arguments.count < 2 {
            let userInput = askUserInput(message: "분석할 JSON 문자열을 입력하세요.")
            guard let inputString = userInput else {
                throw InputError.voidInput
            }
            return (contents: inputString, outputPath: "", type: InputType.console)
        }
        if arguments.count == 2 {
            let inputFileContents = try readFile(currentDirectory + String(arguments[1]))
            let outputPath = currentDirectory + "default.json"
            
            return (contents:inputFileContents, outputPath: outputPath, type: InputType.file)
        }
        if arguments.count > 2 {
            let inputFileContents = try readFile(currentDirectory + String(arguments[1]))
            let outputPath = currentDirectory + String(arguments[2])
            
            return (contents: inputFileContents, outputPath: outputPath, type: InputType.file)
        }
        
        return (contents: "", outputPath: "", type: InputType.console)
    }
    
    func readFile(_ path: String) throws -> String {
        let contents = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        return contents
    }
    
    func askUserInput(message: String) -> String? {
        print(message)
        let userInput = readLine()
        return userInput
    }
    
}

