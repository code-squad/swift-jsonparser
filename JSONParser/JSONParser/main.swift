//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func executeJSONParser(rawJSONData: String) -> JSONData? {
    let outputView = OutputView()
    let parser = JSONParser()
    do {
        return try parser.makeJSONData(rawJSONData)
    } catch ErrorCode.invalidJSONStandard {
        outputView.printErrorMsg(errorCode: .invalidJSONStandard)
    } catch ErrorCode.invalidPatten {
        outputView.printErrorMsg(errorCode: .invalidPatten)
    } catch {
        outputView.printErrorMsg(errorCode: .invalidInputString)
    }
    return nil
}

func readJSONFile(name: String) -> String? {
    let location = "/Users/Mrlee/Documents/CodeSquad_Napster/iOS Level 2/swift-jsonparser/JSONParser/"
    let fileContent = try? String(contentsOfFile: location + name, encoding: String.Encoding.utf8)
    return fileContent
}

func makeJSONFile(contents: String, writeFileName: String?) {
    let location = "/Users/Mrlee/Documents/CodeSquad_Napster/iOS Level 2/swift-jsonparser/JSONParser/"
    var filePath = "output.json"
    if writeFileName != nil { filePath = writeFileName! }
    do {
        try contents.write(toFile: location + filePath, atomically: false, encoding: String.Encoding.utf8)
        OutputView.printSuccessMsg()
    } catch let error as NSError {
        OutputView.printAPIErrorMsg(errorCode: error)
    }
}

func ramifyExecuting() {
    let outputView = OutputView()
    if CommandLine.argc == 1 {
        let inputView = InputView()
        var repeatCondition = true
        while repeatCondition {
            print("분석할 JSON 데이터를 입력하세요.")
            guard let rawJSONData = inputView.read() else {
                outputView.printErrorMsg(errorCode: .invalidInputString)
                return
            }
            if let vaildJSON = executeJSONParser(rawJSONData: rawJSONData) {
                outputView.printJSONAnalysis(vaildJSON)
                repeatCondition = false
            }
        }
    }
    if CommandLine.argc == 2 {
        var repeatCondition = true
        while repeatCondition {
            guard let rawJSON = readJSONFile(name: CommandLine.arguments[1]) else {
                outputView.printErrorMsg(errorCode: .invalidCommandlineArgument)
                return
            }
            if let vaildJSON = executeJSONParser(rawJSONData: rawJSON) {
                makeJSONFile(contents: vaildJSON.showJSONData(1), writeFileName: nil)
                repeatCondition = false
            }
        }
    }
    if CommandLine.argc == 3 {
        var repeatCondition = true
        while repeatCondition {
            guard let rawJSON = readJSONFile(name: CommandLine.arguments[1]) else {
                outputView.printErrorMsg(errorCode: .invalidCommandlineArgument)
                return
            }
            if let vaildJSON = executeJSONParser(rawJSONData: rawJSON) {
                makeJSONFile(contents: vaildJSON.showJSONData(1), writeFileName: CommandLine.arguments[2])
                repeatCondition = false
            }
        }
    }
    
}

ramifyExecuting()
