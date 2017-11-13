//
//  InputView.swift
//  JSONParser
//
//  Created by yangpc on 2017. 10. 30..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    typealias IOFileNames = (inputFileName: String, outputFileName: String?)
    static func read() -> String? {
        print("분석할 JSON 데이터를 입력하세요.")
        let input = readLine() ?? ""
        if input == "" { return nil }
        return input
    }
    
    static func readIO() -> IOFileNames{
        let argCount = CommandLine.argc
        // input파일, output파일
        if argCount > 2 {
            let inputFile = CommandLine.arguments[1]
            let outputFile = CommandLine.arguments[2]
            return IOFileNames(inputFile, outputFile)
        } else {
            let inputFile = CommandLine.arguments[1]
            return IOFileNames(inputFile, nil)
        }
    }
    
    static func loadJSON(_ inputFileName: String) throws -> String {
        let dir = FileManager.default.homeDirectoryForCurrentUser
        let pathURL = dir.appendingPathComponent(inputFileName)
        do {
            let jsonString = try String(contentsOf: pathURL)
            return jsonString
        } catch {
            throw InputView.InputError.notFindFile
        }
    }

}

extension InputView {
    enum InputError: String, Error {
        case notFindFile = "파일을 찾을 수 없습니다."
    }
}

