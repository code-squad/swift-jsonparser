//
//  ArgumentCommand.swift
//  JSONParser
//
//  Created by 윤동민 on 03/12/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct ExecutorByArgument {
    enum ArgumentState : Int { case oneArgument = 2, twoArgument }
    
    // CommandLine으로 넘어온 Argument의 상태를 확인
    static func checkCommandLineState() -> ArgumentState? {
        if CommandLine.arguments.count == 2 { return .oneArgument }
        else if CommandLine.arguments.count == 3 { return .twoArgument }
        else { return nil }
    }
    
    // CommandLine으로 들어온 Argument의 상태에 따라 Input을 다르게 받음
    static func inputByCommanLine(of argumentState : ArgumentState?) -> String {
        let input : String
        if argumentState == nil { input = InputView.UserInput(message: "분석할 JSON문자열을 입력하세요.") }
        else {
            guard let textFromFile = FileReaderWriter.readFile(in: CommandLine.arguments[1]) else { return "" }
            input = textFromFile
        }
        return input
    }
    
    static func outputByCommandLine(of argumentState : ArgumentState?, with json : SupportableJSON) {
        guard let argumentState = argumentState else {                                        // CommandLine으로 Argument가 들어오지 않은 경우 콘솔에 출력
            OutputView.printTypeCount(json)
            OutputView.printJSONSting(json)
            return
        }
        switch argumentState {
        case .oneArgument:                                                                    // CommandLine으로 Argument가 들어온 경우 Argument에 따라 실행
            FileReaderWriter.writeFile(on: "output.json", with: json.createJSONString())
        case .twoArgument:
            FileReaderWriter.writeFile(on: CommandLine.arguments[2], with: json.createJSONString())
        }
    }
    
}
