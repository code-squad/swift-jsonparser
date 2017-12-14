//
//  JsonData.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 12..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct CountingData {
    private (set) var countOfNumericValue: Int
    private (set) var countOfBooleanValue: Int
    private (set) var countOfStringValue: Int
    var countOfTotalValue: Int {
        return self.countOfNumericValue + self.countOfBooleanValue + self.countOfStringValue
    }
}
