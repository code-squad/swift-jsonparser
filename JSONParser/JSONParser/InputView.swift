//
//  InputView.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    enum InputError: String, Error {
        case fileNameError = "확장자(.json)를 확인해주세요."
        case pathError = "파일 경로를 확인해주세요."
        case fileURLError = "파일 내용을 읽는 데 실패했습니다."
    }
    
    static func getData(from inputFileName: String) throws -> String {
        let path = Bundle.main.path(forResource: inputFileName, ofType: nil)
        do {
            guard let fileURL = path else { throw InputError.fileNameError }
            let content = try String(contentsOfFile: fileURL, encoding: .utf8)
            return content
        }catch {
            throw InputError.fileURLError
        }
    }
    
    static func terminalMode(manualMessage: String) throws -> (String, String?) {
        var inputFileName: String
        var outputFileName: String?
        // 첫번째 인자 저장.
        inputFileName = CommandLine.arguments[1]
        // 인자가 2개 이상인 경우.
        if CommandLine.argc > 2 {
            // 두번째 인자 저장.
            outputFileName = CommandLine.arguments[2]
        }
        return (inputFileName, outputFileName)
    }
    
    // 사용자 입력값의 json 규격 체크 후 반환.
    static func askFor(message: String) throws -> String? {
        // 요구 메시지 출력.
        print("\(message)", terminator: " ")
        // q 또는 quit 입력 시 종료.
        guard let inputLine = readLine(), inputLine != "q" && inputLine != "quit" else { return nil }
        return inputLine
    }
    
}
