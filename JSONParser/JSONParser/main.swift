//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

/*
 분석할 JSON 데이터를 입력하세요.
 { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true }
 총 4개의 객체 데이터 중에 문자열 2개, 숫자 1개, 부울 1개가 포함되어 있습니다.
 
 분석할 JSON 데이터를 입력하세요.
 [ { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true },
 { "name" : "YOON JISU", "alias" : "crong", "level" : 4, "married" : true } ]
 총 2개의 배열 데이터 중에 객체 2개가 포함되어 있습니다.
 
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
        let token = try lexer.lex()
        var parser = JSONParser(token)
        let jsonData = try parser.parse()
        OutputView.printResult(jsonData)

    } catch let error {
        print(error)
        print("--------------")
    }
}



