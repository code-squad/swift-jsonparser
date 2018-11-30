//
//  JSONAnalyzer.swift
//  JSONParser
//
//  Created by 김장수 on 30/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONAnalyzer {
    let inputView = InputView()
    let outputView = OutputView()
    let jsonParser = JSONParser()
    let grammarChecker = GrammarChecker()
    
    // input 파일과 output 파일을 입력하지 않은 경우
    func execute() {
        // 입력을 받고, 에러를 처리
        let input = inputView.getInput(ment: "분석할 JSON 데이터를 입력하세요.")
        let error = grammarChecker.textErrorCheck(of: input)
        if error != .noError {
            print(error.rawValue)
            return
        }
        
        // 에러 처리된 입력을 문자열 변환하고 출력
        guard let jsonData = jsonParser.parse(from: input) else { return }
        outputView.printResult(by: jsonData)
        
    }
    
    // input 파일 입력한 경우, input 파일과 output 파일을 모두 입력한 경우
    func execute(from inputFile: String, to outputFile: String?) {
        guard let rawData = readContents(from: inputFile) else {
            print(ErrorList.failReadContents.rawValue)
            return
        }
        guard let jsonData = jsonParser.parse(from: rawData) else {
            print(ErrorList.parsingError.rawValue)
            return
        }

        createFile(name: outputFile, with: outputView.printParsedContents(by: jsonData))
    }
    
    // 파일로부터 내용을 읽어들이는 메소드
    private func readContents(from file: String) -> String? {
        let repository = FileManager.default.currentDirectoryPath, path = "/\(file)"
        let contents = try? String(contentsOfFile: repository + path, encoding: String.Encoding.utf8)
        return contents
    }
    
    // 파싱된 문자열로 파일을 만드는 메소드
    private func createFile(name: String?, with contents: String) {
        var file = "output.json"
        if name != nil { file = name ?? String() }
        let repository = FileManager.default.currentDirectoryPath, path = "/\(file)"
        try! contents.write(toFile: repository + path, atomically: false, encoding: String.Encoding.utf8)
    }
}
