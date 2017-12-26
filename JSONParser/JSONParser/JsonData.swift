//
//  JsonData.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 12..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JsonData {
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
