//
//  CountInfo.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct CountInfo {
    private (set) var countOfInt : Int
    private (set) var countOfBool : Int
    private (set) var countOfString : Int
    private (set) var countOfObject : Int
    private (set) var countOfArray : Int
    private (set) var countOfJSONData : Int

    init (countOfInt: Int = 0,
          countOfBool: Int = 0,
          countOfString: Int = 0,
          countOfObject: Int = 0,
          countOfArray: Int = 0,
          countOfJSONData: Int = 0) {
        self.countOfInt = countOfInt
        self.countOfBool = countOfBool
        self.countOfString = countOfString
        self.countOfObject = countOfObject
        self.countOfArray = countOfArray
        self.countOfJSONData = countOfJSONData
    }

}
