//
//  OutputVIew.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 5..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    private func makeResultMessage(_ info : CountInfo) -> String {
        var result = ""
        
        if info.countOfInt != 0 {
            result.append("숫자 \(info.countOfInt)개 ")
        }
        if info.countOfBool != 0 {
            result.append("부울 \(info.countOfBool)개 ")
        }
        if info.countOfString != 0 {
            result.append("문자열 \(info.countOfString)개 ")
        }
        if info.countOfObject != 0 {
            result.append("객체 \(info.countOfObject)개 ")
        }
        if info.countOfArray != 0 {
            result.append("배열 \(info.countOfArray)개 ")
        }
        return result
    }
    
    private func selectType(_ info: Parser.ParseTarget) -> String {
        
        switch info {
        case .list:
            return info.description
        case .object:
            return info.description
        }
    }

    func showResult(_ countInfo: CountInfo, _ parseType: Parser.ParseTarget, text resultText: String) {
        print("\(countInfo.countOfJSONData)개 \(selectType(parseType)) 데이터 중에 \(makeResultMessage(countInfo))가 포함되어 있습니다.")
        print(resultText)
    }
    /*
    func makeOutputFile(result resultText: String, fileName outputFileName: String, fileType outputFileType: String) {
        let path = Bundle.main.path(forResource: outputFileName, ofType: outputFileType)
        
         try! resultText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
    }
    */
    
    
}
