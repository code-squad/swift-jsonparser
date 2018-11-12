//
//  NumberByType.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 12..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct NumberByType {
    private var string : Int
    private var number : Int
    private var bool : Int
    
    init(string:Int, number:Int, bool:Int) {
        self.string = string
        self.number = number
        self.bool = bool
    }
    
    func numberOfString() -> Int{
        return self.string
    }
    func numberOfNumber() -> Int{
        return self.number
    }
    func numberOfBool() -> Int{
        return self.bool
    }
}
