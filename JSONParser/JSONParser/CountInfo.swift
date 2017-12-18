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
    private (set) var countOfJSONData = 0

    init (intCnt countOfInt: Int, boolCnt countOfBool: Int, stringCnt countOfString: Int, objentCnt countOfObject: Int, allCnt countOfJSONData: Int) {
        self.countOfInt = countOfInt
        self.countOfBool = countOfBool
        self.countOfString = countOfString
        self.countOfObject = countOfObject
        self.countOfJSONData = countOfJSONData
    }

}
