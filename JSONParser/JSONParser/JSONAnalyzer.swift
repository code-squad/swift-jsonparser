//
//  MakeJSONFile.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 12. 1..
//  Copyright © 2017년 Napster. All rights reserved.
//

import Foundation

struct JSONAnalyzer {
    private let inputView = InputView()
    private let outputView = OutputView()
    
    func make() {
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
            guard let rawJSON = inputView.readFile(name: inputFile) else {
                OutputView.printErrorMsg(errorCode: .invalidCommandlineArgument)
                return
            }
            if let vaildJSON = executeParser(rawJSONData: rawJSON) {
                outputView.writeFile(contents: vaildJSON.showJSONData(1), writeFileName: outputFile)
                repeatCondition = false
            }
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
