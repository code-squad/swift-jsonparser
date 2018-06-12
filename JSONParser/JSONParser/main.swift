//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main(){
    // 입력담당 구조체 선언
    let inputView = InputView()
    // 유저입력을 받는다
    let userInput = inputView.receiveUserInput()
    
    // 입력값을 분류해주는 구조체 선언
    let classifier = Classifier()
    // 입력값을 JSON 스타일로 나눔
    guard let separatedLetters = classifier.surveyForJSON(letters: userInput) else {
        inputView.printWrongInputMessage()
        return ()
    }
    
    // JSON 파서 구조체 선언
    let jsonParser = JSONParser()
    
    // JSON Data 생성
    guard let dataOfJSON = jsonParser.transform(letters: separatedLetters) else {
        inputView.printWrongInputMessage()
        return ()
    }
    
    // 출력 구조체 선언
    let outputView = OutputView()
    outputView.printCountOfTypes(json: dataOfJSON)
}

// 메인함수 실행
main()

