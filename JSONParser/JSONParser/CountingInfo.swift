//
//  CountingInfo.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct CountingInfo {
    var countOfInt = 0
    var countOfBool = 0
    var countOfString = 0
    var countOfJSONData = 0

    init (_ countOfInt: Int, _ countOfBool: Int, _ countOfString: Int, _ countOfJSONData: Int) {
        self.countOfInt = countOfInt
        self.countOfBool = countOfBool
        self.countOfString = countOfString
        self.countOfJSONData = countOfJSONData
    }
    
}
