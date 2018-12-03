//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main() {
    let arguments = CommandLine.arguments
    var (input,url) : (String,URL?)
    if arguments.count == 1 {
        (input,url) = InputView.readEnter(ment: "분석할 JSON 데이터를 입력하세요.")
    } else if arguments.count == 2 {
        (input,url) = InputView.readContent(readFileName: arguments[1], saveFileName: "output.json")
    } else {
        (input,url) = InputView.readContent(readFileName: arguments[1], saveFileName: arguments[2])
    }
    
    guard GrammarChecker.checkInputData(data: input) else {print("지원하지 않는 형식을 포함하고 있습니다.");return}
    guard let jsonData = Parser.convert(string: input) else {return}
    
    OutputView.saveJSONData(jsonData: jsonData, path: url)
}

main()
