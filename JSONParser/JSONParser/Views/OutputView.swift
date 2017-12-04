//
//  OutputView.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 13..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {    
    func printJSONAnalysis(_ value: JSONData) {
            print("총 \(value.countData()) 데이터 중에", terminator: "")
            printJSONData(value.analyzeData())
            print("가 포함되어 있습니다.")
            print("\(value.showJSONData(1))")
    }
    
    static func printErrorMsg(errorCode: ErrorCode) {
        print("\(errorCode.rawValue)")
    }
    
    static func printAPIErrorMsg(errorCode: NSError) {
        print("ErrorCode: \(errorCode)")
    }
    
    static func printSuccessMsg() {
        print("성공적으로 파일을 생성하였습니다.")
    }
    
    private func printJSONData(_ jsonData: JSONAnalysisData) {
        
        func printComma(_ jsonDataCount: Int) -> String {
            return (jsonData.sumOfData > jsonDataCount) ? "," : ""
        }
        if jsonData.stringTypeCount > 0 {
            print(" 문자열 \(jsonData.stringTypeCount)개", terminator: printComma(jsonData.stringTypeCount))
        }
        if jsonData.intTypeCount > 0 {
            print(" 숫자 \(jsonData.intTypeCount)개", terminator: printComma(jsonData.intTypeCount))
        }
        if jsonData.boolTypeCount > 0 {
            print(" 부울 \(jsonData.boolTypeCount)개", terminator: printComma(jsonData.boolTypeCount))
        }
        if jsonData.objectTypeCount > 0 {
            print(" 객체 \(jsonData.objectTypeCount)개", terminator: printComma(jsonData.objectTypeCount))
        }
        if jsonData.arrayTypeCount > 0 {
            print(" 배열 \(jsonData.arrayTypeCount)개", terminator: "")
        }
    }
}

extension OutputView {
    func writeFile(contents: String, writeFileName: String?) {
        let location = "/Users/Mrlee/Documents/CodeSquad_Napster/iOS Level 2/swift-jsonparser/JSONParser/"
        var fileName = "output.json"
        if writeFileName != nil { fileName = writeFileName! }
        do {
            try contents.write(toFile: location + fileName, atomically: false, encoding: String.Encoding.utf8)
            OutputView.printSuccessMsg()
        } catch let error as NSError {
            OutputView.printAPIErrorMsg(errorCode: error)
        }
    }
}
