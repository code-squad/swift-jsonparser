//
//  OutView.swift
//  JSONParser
//
//  Created by Yoda Codd on 2018. 5. 21..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation
struct OutputView {
    
    
    /// JSON 데이터중 입력받은 자료형 타입이 몇개인지 리턴
    private func countThat(targetType : Any.Type, dataSet : [Any] ) -> Int {
        // 결과값 변수 선언
        var countOfLetter = 0
        // JSON 배열을 반복문에 넣는다
        for data in dataSet {
            if ObjectIdentifier(type(of:data)) == ObjectIdentifier(targetType) {
                countOfLetter += 1
            }
        }
        return countOfLetter
    }
    
    /// 숫자 형태 값이 몇개인지 리턴
    func countNumberType(dataSet : [Any]) -> Int{
        // 인트 타입 변수
        let intType : Int.Type = Int.self
        // 계산함수를 리턴한다
        return countThat(targetType: intType, dataSet : dataSet)
    }
    
    /// 문자 형태 값이 몇개인지 리턴
    func countLetterType(dataSet : [Any]) -> Int{
        // 인트 타입 변수
        let intType : String.Type = String.self
        // 계산함수를 리턴한다
        return countThat(targetType: intType, dataSet : dataSet)
    }
    
    /// Bool 형태 값이 몇개인지 리턴
    func countBoolType(dataSet : [Any]) -> Int{
        // 인트 타입 변수
        let intType : Bool.Type = Bool.self
        // 계산함수를 리턴한다
        return countThat(targetType: intType, dataSet : dataSet)
    }
}
