//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation
/*
 JSON 데이터 규격을 이해하고, JSON 데이터를 분석해서 원하는 데이터 구조 형태로 변환하는 분석기를 개발한다.
 - 사용자가 JSON 문자열을 입력하는 메뉴를 구성한다.
 - 입력한 문자열을 분석해서 처리하는 프로그램을 작성한다.
 - 구조체 이름을 스스로 결정해본다.
 - 지원하는 규격이 아닌 경우 처리하지 않는 예외처리 로직을 추가한다.
 - "정규표현식을 사용하지 않고" 최대한 직접 처리한다.
 
 단순한 JSON 배열(array) 문자열을 입력하면 내부 요소들을 분석해서 Swift Array로 저장
 JSON 배열에 포함될 수 있는 데이터는 문자열(String), 숫자(Number), 부울 true/false(Bool) 만 가능하다고 가정한다.
 JSON 요소를 저장한 배열에서, 각 타입을 문자열, 숫자, 부울 요소로 구분해서 개수를 출력한다.
 
 JSON 표준 규격에 대해 검색해보고 자료를 찾아 학습한다.
 JSON 요소와 매칭되는 스위프트 데이터 타입에 대해 학습한다.
 스위프트 배열에 여러 타입을 저장하고 꺼내서 처리하는 방식에 대해 학습한다.
 
 */

//[ 10, "jk", 4, "314", 99, "crong", false ]
let main = {
    /// 입력
    var data = ""
    while true {
        do {
            data = try InputView.readStringJsonData()
            try Validation.checkInvalidArrayFormat(data)
            break
        } catch let errorType as ErrorCode  {
            print(errorType.description)
        }
    }
    /// 처리

    Tokenizer.tokenize(data)
    /// 출력
}

try main()


