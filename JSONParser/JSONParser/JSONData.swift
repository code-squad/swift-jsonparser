//
//  JSONData.swift
//  JSONParser
//
//  Created by Yoda Codd on 2018. 5. 25..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

/// JSON 데이터들이 준수하게 될 프로토콜 선언
protocol JSONCount {
    func countValues() -> String
}

/// JSON 배열타입 데이터
struct JSONArray : JSONCount {
    // 데이터를 배열로 담는다
    private let dataSetOfJSON : [Any]
    
    // 생성자
    init(dataSetOfJSON : [Any]){
        self.dataSetOfJSON = dataSetOfJSON
    }
    
    // 프로토콜을 준수한다
    func countValues() -> String {
        let checker = Checker()
        
        let countOfNumber = checker.countIntFrom(targetArray: dataSetOfJSON)
        // 문자형 타입의 개수를 받을 변수 선언
        let countOfLetter = checker.countStringFrom(targetArray: dataSetOfJSON)
        // Bool 형 타입의 개수를 받을 변수 선언
        let countOfBool = checker.countBoolFrom(targetArray: dataSetOfJSON)
        // 객체 타입 개수를 받을 변수 선언
        let countOfObject = checker.countObjectFrom(targetArray: dataSetOfJSON)
        // 합계 계산
        let totalCount = countOfNumber + countOfLetter + countOfBool + countOfObject
        // 요구조건의 형태대로 출력
        return ("총 \(totalCount)개의 배열 데이터 중에 문자열 \(countOfLetter)개, 숫자 \(countOfNumber)개, 부울 \(countOfBool)개, 객체 \(countOfObject)개가 포함되어 있습니다.")
    }
}

/// JSON Object 타입
struct JSONObject : JSONCount {
    // 데이터를 딕셔너리로 담는다
    private let dataSetOfJSON : [String : Any]
    
    // 생성자
    init(dataSetOfJSON : [String : Any]){
        self.dataSetOfJSON = dataSetOfJSON
    }
    
    // 프로토콜을 준수. 데이터 타입을 종류별로 카운트 해서 리턴
    func countValues() -> String {
        let checker = Checker()
        // 숫자형 타입의 개수를 받을 변수 선언
        let countOfNumber = checker.countIntFrom(targetObject: dataSetOfJSON)
        // 문자형 타입의 개수를 받을 변수 선언
        let countOfLetter = checker.countStringFrom(targetObject: dataSetOfJSON)
        // Bool 형 타입의 개수를 받을 변수 선언
        let countOfBool = checker.countBoolFrom(targetObject: dataSetOfJSON)
        // 합계 계산
        let totalCount = countOfNumber + countOfLetter + countOfBool
        // 요구조건의 형태대로 출력
        return ("총 \(totalCount)개의 데이터 중에 문자열 \(countOfLetter)개, 숫자 \(countOfNumber)개, 부울 \(countOfBool)개가 포함되어 있습니다.")
    }
}

