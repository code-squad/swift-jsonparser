//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main() {
    let jsonAnalyzer = JSONAnalyzer()
    let arguments = CommandLine.arguments
    
    switch arguments.count {
    case 1:
        jsonAnalyzer.execute()                                          // 처리하려는 파일을 입력하지 않은 경우
    case 2:
        jsonAnalyzer.execute(from: arguments[1], to: nil)               // 처리하려는 파일만 입력한 경우
    case 3:
        jsonAnalyzer.execute(from: arguments[1], to: arguments[2])      // 처리하려는 파일과 생성하려는 파일 모두 입력한 경우
    default:
        print(ErrorList.wrongInput.rawValue)
    }
}

main()
