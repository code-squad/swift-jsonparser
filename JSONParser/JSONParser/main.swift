//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

// 요구사항, 접근방법, 코드

// JSON배열 문자열을 입력하면 내부 요소들을 분석해서 배열로 저장하고
// 문자열, 숫자, 부울 요소의 개수를 출력한다.
/*
분석할 JSON 데이터를 입력하세요.
[ 10, 21, 4, 314, 99, 0, 72 ]
총 7개의 데이터 중에 숫자 7개가 포함되어 있습니다.
 
분석할 JSON 데이터를 입력하세요.
[ 10, "jk", 4, "314", 99, "crong", false ]
총 7개의 데이터 중에 문자열 3개, 숫자 3개, 부울 1개가 포함되어 있습니다.
*/
import Foundation

func checkQuit(_ input:String) {
    if input == "q" {
        print ("종료합니다.")
        exit(0)
    }
}

while true {
    do {
        
        let input = try InputView.readInput(question: "분석할 JSON 데이터를 입력하세요.")
        checkQuit(input)
        
        var lexer = JSONLexer(input: input)
        let tokens = try lexer.lex()
        let (stringCount, boolCount, numberCount) = JSONParser.parse(tokens)
        OutputView.printResult(stringCount, boolCount, numberCount)
    } catch let error {
        print(error)
        print("--------------")
    }
}



