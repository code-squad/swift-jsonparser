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
    private func countNumberType(dataSet : [Any]) -> Int{
        // 인트 타입 변수
        let intType : Int.Type = Int.self
        // 계산함수를 리턴한다
        return countThat(targetType: intType, dataSet : dataSet)
    }
    
    /// 문자 형태 값이 몇개인지 리턴
    private func countLetterType(dataSet : [Any]) -> Int{
        // 인트 타입 변수
        let intType : String.Type = String.self
        // 계산함수를 리턴한다
        return countThat(targetType: intType, dataSet : dataSet)
    }
    
    /// Bool 형태 값이 몇개인지 리턴
    private func countBoolType(dataSet : [Any]) -> Int{
        // 인트 타입 변수
        let intType : Bool.Type = Bool.self
        // 계산함수를 리턴한다
        return countThat(targetType: intType, dataSet : dataSet)
    }
    
    /// JSON 데이터를 받아서 각 항목이 몇개인지 출력
    func printCountOfTypes(dataSet : [Any]){
        // 숫자형 타입의 개수를 받을 변수 선언
        let countOfNumber = countNumberType(dataSet: dataSet)
        // 문자형 타입의 개수를 받을 변수 선언
        let countOfLetter = countLetterType(dataSet: dataSet)
        // Bool 형 타입의 개수를 받을 변수 선언
        let countOfBool = countBoolType(dataSet: dataSet)
        // 합계 계산
        let totalCount = countOfNumber + countOfLetter + countOfBool
        // 요구조건의 형태대로 출력
        print("총 \(totalCount)개의 데이터 중에 문자열 \(countOfLetter)개, 숫자 \(countOfNumber)개, 부울 \(countOfBool)개가 포함되어 있습니다.")
    }
}
