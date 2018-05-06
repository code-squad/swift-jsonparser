//
//  InputView.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 16..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

enum Question: String {
    case askJSONData = "분석할 JSON 데이터를 입력하세요."
}

struct InputView {
    
    enum Error: Swift.Error {
        case invalidInputFileName
        case readFailFromFile
        
        var errorMessage: String {
            switch self {
            case .invalidInputFileName:
                return "파일이름이 잘못되었습니다."
            case .readFailFromFile:
                return "파일로부터 Input 읽기 실패"
            }
        }
    }
    
    private static let defaultOutputFileName: String = "output.json"
    
    static func readInput(_ question: Question) -> String? {
        print(question.rawValue)
        guard let input = readLine() else {
            return nil
        }
        
        return input
    }

    static func readInputFromFile(_ inputFileName: String) throws -> String {
        guard let fileURL = Bundle.main.path(forResource: inputFileName, ofType: nil) else {
            throw InputView.Error.invalidInputFileName
        }
        guard let input = try? String(contentsOfFile: fileURL, encoding: .utf8) else {
            throw InputView.Error.readFailFromFile
        }
        return input
    }
}
