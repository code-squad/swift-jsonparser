//
//  CountInfo.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct CountInfo {
    var countOfInt = 0
    var countOfBool = 0
    var countOfString = 0
    var countOfObject = 0
    var countOfJSONData = 0

    init (i countOfInt: Int, b countOfBool: Int, s countOfString: Int, o countOfObject: Int, all countOfJSONData: Int) {
        self.countOfInt = countOfInt
        self.countOfBool = countOfBool
        self.countOfString = countOfString
        self.countOfObject = countOfObject
        self.countOfJSONData = countOfJSONData
    }

}
