//
//  OutputView.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    enum OutputError: String, Error {
        case pathError = "파일 경로를 확인해주세요."
        case fileURLError = "파일 내용을 쓰는 데 실패했습니다."
    }
    
    static func writeData(_ prettyData: String, into outputFileName: String) throws {
        do {
            try prettyData.write(toFile: outputFileName, atomically: true, encoding: .utf8)
        }catch {
            throw OutputError.fileURLError
        }
    }
    
    // JSON 관련 에러 출력.
    static func printError(_ error: GrammarChecker.JsonError) {
        print(error.rawValue)
    }
    
}
