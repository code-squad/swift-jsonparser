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
class JSONArray : JSONCount {
    // 데이터를 배열로 담는다
    private let dataSetOfJSON : [Any]
    
    // 생성자
    init(dataSetOfJSON : [Any]){
        self.dataSetOfJSON = dataSetOfJSON
    }
    
    // 프로토콜을 준수한다
    func countValues() -> String {
        let countOfNumber = countNumberType()
        // 문자형 타입의 개수를 받을 변수 선언
        let countOfLetter = countLetterType()
        // Bool 형 타입의 개수를 받을 변수 선언
        let countOfBool = countBoolType()
        // 객체 타입 개수를 받을 변수 선언
        let countOfObject = countOfObjectType()
        // 합계 계산
        let totalCount = countOfNumber + countOfLetter + countOfBool + countOfObject
        // 요구조건의 형태대로 출력
        return ("총 \(totalCount)개의 배열 데이터 중에 문자열 \(countOfLetter)개, 숫자 \(countOfNumber)개, 부울 \(countOfBool)개, 객체 \(countOfObject)개가 포함되어 있습니다.")
    }
    
    /// JSON 데이터중 입력받은 자료형 타입이 몇개인지 리턴
    private func countThat(targetType : Any.Type) -> Int {
        // 결과값 변수 선언
        var countOfLetter = 0
        // JSON 배열을 반복문에 넣는다
        for data in dataSetOfJSON {
            if ObjectIdentifier(type(of: data)) == ObjectIdentifier(targetType) {
                countOfLetter += 1
            }
        }
        return countOfLetter
    }
    
    /// 숫자 형태 값이 몇개인지 리턴
    func countOfObjectType() -> Int{
        // 인트 타입 변수
        let dictionaryType : [String:Any] = [:]
        // 계산함수를 리턴한다
        return countThat(targetType: type(of:dictionaryType))
    }
    
    /// 숫자 형태 값이 몇개인지 리턴
    func countNumberType() -> Int{
        // 인트 타입 변수
        let intType : Int.Type = Int.self
        // 계산함수를 리턴한다
        return countThat(targetType: intType)
    }
    
    /// 문자 형태 값이 몇개인지 리턴
    func countLetterType() -> Int{
        // 인트 타입 변수
        let intType : String.Type = String.self
        // 계산함수를 리턴한다
        return countThat(targetType: intType)
    }
    
    /// Bool 형태 값이 몇개인지 리턴
    func countBoolType() -> Int{
        // 인트 타입 변수
        let intType : Bool.Type = Bool.self
        // 계산함수를 리턴한다
        return countThat(targetType: intType)
    }
}

/// JSON Object 타입
class JSONObject : JSONCount {
    // 데이터를 딕셔너리로 담는다
    private let dataSetOfJSON : [String : Any]
    
    // 생성자
    init(dataSetOfJSON : [String : Any]){
        self.dataSetOfJSON = dataSetOfJSON
    }
    
    // 프로토콜을 준수. 데이터 타입을 종류별로 카운트 해서 리턴
    func countValues() -> String {
        // 숫자형 타입의 개수를 받을 변수 선언
        let countOfNumber = countNumberType()
        // 문자형 타입의 개수를 받을 변수 선언
        let countOfLetter = countLetterType()
        // Bool 형 타입의 개수를 받을 변수 선언
        let countOfBool = countBoolType()
        // 합계 계산
        let totalCount = countOfNumber + countOfLetter + countOfBool
        // 요구조건의 형태대로 출력
        return ("총 \(totalCount)개의 데이터 중에 문자열 \(countOfLetter)개, 숫자 \(countOfNumber)개, 부울 \(countOfBool)개가 포함되어 있습니다.")
    }
    
    /// JSON 데이터중 입력받은 자료형 타입이 몇개인지 리턴
    private func countThat(targetType : Any.Type) -> Int {
        // 결과값 변수 선언
        var countOfLetter = 0
        // JSON 배열을 반복문에 넣는다
        for keyData in dataSetOfJSON.keys {
            if ObjectIdentifier(type(of:keyData)) == ObjectIdentifier(targetType) {
                countOfLetter += 1
            }
        }
        return countOfLetter
    }
    
    /// 숫자 형태 값이 몇개인지 리턴
    func countNumberType() -> Int{
        // 인트 타입 변수
        let intType : Int.Type = Int.self
        // 계산함수를 리턴한다
        return countThat(targetType: intType)
    }
    
    /// 문자 형태 값이 몇개인지 리턴
    func countLetterType() -> Int{
        // 인트 타입 변수
        let intType : String.Type = String.self
        // 계산함수를 리턴한다
        return countThat(targetType: intType)
    }
    
    /// Bool 형태 값이 몇개인지 리턴
    func countBoolType() -> Int{
        // 인트 타입 변수
        let intType : Bool.Type = Bool.self
        // 계산함수를 리턴한다
        return countThat(targetType: intType)
    }
    
}
