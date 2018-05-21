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
    static let booleanType = ["false","true"]
    
    // 생성자
    init(countOfNumber : Int, countOfLetters : Int, countOfBool : Int){
        self.countOfNumber = countOfNumber
        self.countOfLetters = countOfLetters
        self.countOfBool = countOfBool
    }
    
    // JSON 의 숫자형 데이터의 개수
    private var countOfNumber = 0
    // JSON 의 문자열 데이터의 개수
    private var countOfLetters = 0
    // JSON 의 Bool 데이터의 개수
    private var countOfBool = 0
    
    // 각 개수의 설정 함수
    mutating func setCountOfNumber(number : Int){
        countOfNumber = number
    }
    func getCountOfNumber() -> Int{
        return countOfNumber
    }
    mutating func setCountOfLetters(number : Int){
        countOfLetters = number
    }
    func getCountOfLetters() -> Int{
        return countOfLetters
    }
    mutating func setCountOfBool(number : Int){
        countOfBool = number
    }
    func getCountOfBool() -> Int{
        return countOfBool
    }
}
