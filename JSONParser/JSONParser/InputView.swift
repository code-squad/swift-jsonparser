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
    static func read() throws -> String? {
        let argCount = CommandLine.argc
        do {
            switch argCount {
            case 1:
                guard let jsonString = readFromConsole() else { return nil }
                return jsonString
            case 2, 3:
                let inputFileName = CommandLine.arguments[1]
                let jsonString = try loadJSON(inputFileName)
                return jsonString
            default: break
            }
        } catch let error {
            throw error
        }
        return nil
        
    }
    
    private static func readFromConsole() -> String? {
        print("분석할 JSON 데이터를 입력하세요.")
        let input = readLine() ?? ""
        if input == "" { return nil }
        return input
    }

    private static func loadJSON(_ inputFileName: String) throws -> String {
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
