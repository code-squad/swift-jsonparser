//
//  DistinguishOrder.swift
//  JSONParser
//
//  Created by 윤동민 on 03/12/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct DistinguishOrder {
    // 명령을 구분하여 실행
    static func excuteOrder(of order : FormState, in input : String) {
        switch order {
        case .fileInputForm:
            excuteFileReadForm(input)
        case .userInputForm:
            excuteUserInput(input)
        default:
            print("")
        }
    }
    
    // 파일을 읽어오고 쓰는 명령어일 경우 실행
    static private func excuteFileReadForm(_ fileNames : String) {
        enum ParameterState : Int { case oneParameter = 2, twoParameter, notSupport }
        let inputOutputFileName = fileNames.split(separator: " ").map(String.init)
        guard let fileText = FileReaderWriter.readFile(in: inputOutputFileName[1]) else { return }
        let jsonParser : JSONParser = JSONParser()
        let jsonToSwift = jsonParser.jsonParser(dataToConvert: fileText)
        
        switch ParameterState(rawValue: inputOutputFileName.count) ?? .notSupport {
        case .oneParameter:
            FileReaderWriter.writeFile(on: "output.json", with: jsonToSwift.createJSONString())
        case .twoParameter:
            FileReaderWriter.writeFile(on: inputOutputFileName[2], with: jsonToSwift.createJSONString())
        case .notSupport:
            return
        }
    }
    
    // 사용자가 입력한 값을 기준으로 파싱할 경우 실행
    static private func excuteUserInput(_ input : String) {
        let outputView : OutputView = OutputView()
        let jsonParser : JSONParser = JSONParser()
        let jsonToSwift = jsonParser.jsonParser(dataToConvert: input)
        outputView.printTypeCount(jsonToSwift)
        outputView.printJSONSting(jsonToSwift)
    }
}
