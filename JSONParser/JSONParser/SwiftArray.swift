//
//  SwiftArray.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct SwiftArray {
    private var numbers : [Double] = []
    private var strings : [String] = []
    private var bools : [Bool] = []
    
    mutating func insertIntoNumbers(_ number:Double) {
        self.numbers.append(number)
    }
    mutating func insertIntoStrings(_ string:String) {
        self.strings.append(string)
    }
    mutating func insertIntoBools(_ bool:Bool) {
        self.bools.append(bool)
    }
    

    
}
