//
//  CountInfo.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct CountInfo {
    private var countOfInt = 0
    private var countOfBool = 0
    private var countOfString = 0
    private var countOfObject = 0
    private var countOfJSONData = 0

    init (intCnt countOfInt: Int, boolCnt countOfBool: Int, stringCnt countOfString: Int, objentCnt countOfObject: Int, allCnt countOfJSONData: Int) {
        self.countOfInt = countOfInt
        self.countOfBool = countOfBool
        self.countOfString = countOfString
        self.countOfObject = countOfObject
        self.countOfJSONData = countOfJSONData
    }

}
