//
//  JSONData.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 4. 19..
//  Copyright © 2018년 JK. All rights reserved.
//

struct JSONData: JSONProtocol {

    private var strings: Array<String>
    private var numbers: Array<Int>
    private var booleans: Array<Bool>
    
    init(_ strings: Array<String>, _ numbers: Array<Int>, _ booleans: Array<Bool>) {
        self.strings = strings
        self.numbers = numbers
        self.booleans = booleans
    }
    
    func countOfString() -> Int {
        return self.strings.count
    }
    
    func countOfNumber() -> Int {
        return self.numbers.count
    }
    
    func countOfBoolean() -> Int {
        return self.booleans.count
    }
    
    func getTotalCount() -> Int {
        return countOfNumber() + countOfString() + countOfBoolean()
    }
    
    func descriptionShow() -> String{
        var description = "총 \(getTotalCount())개"
        if countOfString() > 0 {
            description += " 문자열 \(countOfString())개"
        }
        
        if countOfNumber() > 0 {
            description += " 숫자 \(countOfNumber())개"
        }
        
        if countOfBoolean() > 0 {
            description += " 부울 \(countOfBoolean())개"
        }
        description += "가 포함되어 있습니다."
        return description
    }
}
