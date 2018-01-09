//
//  JsonData.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 12..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONData {
    private (set) var ofNumericValue: Int = 0
    private (set) var ofBooleanValue: Int = 0
    private (set) var ofStringValue: Int = 0
    private (set) var ofObject: Int = 0
    private (set) var ofArray: Int = 0
    private (set) var total: Int = 0
    private (set) var type: CountingType
    enum CountingType {
        case object
        case array
        
        func printResultOfConting (countedValue : JSONData) -> String {
            switch self {
            case .object :
                return  ("총 \(countedValue.total)개의 객체중 숫자 \(countedValue.ofNumericValue)개, 불값 \(countedValue.ofBooleanValue)개, 문자열 \(countedValue.ofStringValue)개, 배열 \(countedValue.ofArray)개가 있습니다.")
            case .array :
                return  ("총 \(countedValue.total)개의 배열 데이터중 객체 \(countedValue.ofObject) 숫자 \(countedValue.ofNumericValue)개, 불값 \(countedValue.ofBooleanValue)개, 문자열 \(countedValue.ofStringValue)개, 배열 \(countedValue.ofArray)개가 있습니다.")
            }
        }
    }
    
    // 객체타입 생성자
    init (_ ofNumericValue: Int, _ ofBooleanValue: Int, _ ofStringValue: Int, _ ofArray: Int) {
        self.type = CountingType.object
        self.ofNumericValue = ofNumericValue
        self.ofBooleanValue = ofBooleanValue
        self.ofStringValue = ofStringValue
        self.ofArray = ofArray
        self.total = ofStringValue + ofBooleanValue + ofNumericValue + ofArray
    }
    
    // 배열타입 생성자
    init (_ ofNumericValue: Int, _ ofBooleanValue: Int, _ ofStringValue: Int, _ ofObject: Int, _ ofArray: Int) {
        self.type = CountingType.array
        self.ofNumericValue = ofNumericValue
        self.ofBooleanValue = ofBooleanValue
        self.ofStringValue = ofStringValue
        self.ofObject = ofObject
        self.ofArray = ofArray
        self.total = ofStringValue + ofBooleanValue + ofNumericValue + ofObject + ofArray
    }
}
