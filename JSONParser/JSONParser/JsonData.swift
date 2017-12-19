//
//  JsonData.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 12..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct CountingData {
    private (set) var ofNumericValue: Int = 0
    private (set) var ofBooleanValue: Int = 0
    private (set) var ofStringValue: Int = 0
    private (set) var ofObject: Int = 0
    private (set) var total: Int = 0
    private (set) var type: CountingType
    enum CountingType {
        case object
        case array
    }
    
    init (ofNumericValue: Int, ofBooleanValue: Int, ofStringValue: Int, total: Int) {
        self.type = CountingType.object
        self.ofNumericValue = ofNumericValue
        self.ofBooleanValue = ofBooleanValue
        self.ofStringValue = ofStringValue
        self.total = ofStringValue + ofBooleanValue + ofNumericValue
    }
    
    init (ofNumericValue: Int, ofBooleanValue: Int, ofStringValue: Int, ofObject: Int, total: Int) {
        self.type = CountingType.array
        self.ofNumericValue = ofNumericValue
        self.ofBooleanValue = ofBooleanValue
        self.ofStringValue = ofStringValue
        self.ofObject = ofObject
        self.total = ofStringValue + ofBooleanValue + ofNumericValue + ofObject
    }
}
