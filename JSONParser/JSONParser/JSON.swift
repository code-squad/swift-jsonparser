//
//  JSON.swift
//  JSONParser
//
//  Created by Yoda Codd on 2018. 5. 21..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct JSON {
    // JSON 에서 데이터를 나누는 단위
    static let separater : Character = ","
    // JSON 에서 문자열을 감싸는 단위
    static let letterWrapper : Character = "\""
    // JSON 에서 Bool 타입을 표현하는 문자열의 배열
    static let booleanType = ["false", "true"]
    // JSON 의 처음을 감싸는 배열 확인용 문자
    static let startOfJSON = "["
    // JSON 의 마지막을 감싸는 배열 확인용 문자
    static let endOfJSON = "]"
    
    // JSON 타입의 배열
    private let dataSetOfJSON : [Any] 
    
    // 생성자
    init(dataSetOfJSON : [Any]){
        self.dataSetOfJSON = dataSetOfJSON
    }
    
    /// JSON 데이터중 입력받은 자료형 타입이 몇개인지 리턴
    private func countThat(targetType : Any.Type) -> Int {
        // 결과값 변수 선언
        var countOfLetter = 0
        // JSON 배열을 반복문에 넣는다
        for data in dataSetOfJSON {
            if ObjectIdentifier(type(of:data)) == ObjectIdentifier(targetType) {
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
