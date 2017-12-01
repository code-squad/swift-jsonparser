//
//  MakeJSONFile.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 12. 1..
//  Copyright © 2017년 Napster. All rights reserved.
//

import Foundation

struct JSONAnalyzer {
    private let location = "/Users/Mrlee/Documents/CodeSquad_Napster/iOS Level 2/swift-jsonparser/JSONParser/"

    func make() {
        let inputView = InputView()
        let outputView = OutputView()
        var repeatCondition = true
        while repeatCondition {
            print("분석할 JSON 데이터를 입력하세요.")
            guard let rawJSONData = inputView.read() else {
                OutputView.printErrorMsg(errorCode: .invalidInputString)
                return
            }
            if let vaildJSON = executeParser(rawJSONData: rawJSONData) {
                outputView.printJSONAnalysis(vaildJSON)
                repeatCondition = false
            }
        }
    }
    
    func make(inputFile: String, outputFile: String?) {
        var repeatCondition = true
        while repeatCondition {
            guard let rawJSON = readFile(name: inputFile) else {
                OutputView.printErrorMsg(errorCode: .invalidCommandlineArgument)
                return
            }
            if let vaildJSON = executeParser(rawJSONData: rawJSON) {
                writeFile(contents: vaildJSON.showJSONData(1), writeFileName: outputFile)
                repeatCondition = false
            }
        }
    }
    
    private func readFile(name: String) -> String? {
        let fileContent = try? String(contentsOfFile: location + name, encoding: String.Encoding.utf8)
        return fileContent
    }
    
    private func writeFile(contents: String, writeFileName: String?) {
        var fileName = "output.json"
        if writeFileName != nil { fileName = writeFileName! }
        do {
            try contents.write(toFile: location + fileName, atomically: false, encoding: String.Encoding.utf8)
            OutputView.printSuccessMsg()
        } catch let error as NSError {
            OutputView.printAPIErrorMsg(errorCode: error)
        }
    }
    
    private func executeParser(rawJSONData: String) -> JSONData? {
        let parser = JSONParser()
        do {
            return try parser.makeJSONData(rawJSONData)
        } catch ErrorCode.invalidJSONStandard {
            OutputView.printErrorMsg(errorCode: .invalidJSONStandard)
        } catch ErrorCode.invalidPatten {
            OutputView.printErrorMsg(errorCode: .invalidPatten)
        } catch {
            OutputView.printErrorMsg(errorCode: .invalidInputString)
        }
        return nil
    }

}
