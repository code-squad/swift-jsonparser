//
//  CountInfo.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct CountInfo {
    private (set) var countOfInt = 0
    private (set) var countOfBool = 0
    private (set) var countOfString = 0
    private (set) var countOfObject = 0
    private (set) var countOfArray = 0
    private (set) var countOfJSONData = 0

    init (countOfInt: Int,
          countOfBool: Int,
          countOfString: Int,
          countOfObject: Int,
          countOfArray: Int,
          countOfJSONData: Int) {
        self.countOfInt = countOfInt
        self.countOfBool = countOfBool
        self.countOfString = countOfString
        self.countOfObject = countOfObject
        self.countOfArray = countOfArray
        self.countOfJSONData = countOfJSONData
    }

}
