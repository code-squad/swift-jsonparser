//
//  NumberByType.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 12..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct NumberByType {
    private let string : Int
    private let number : Int
    private let bool : Int
    private let object : Int
    private let array : Int
    private let all : Int
    
    init(array:[JsonType]) {
        var numberOfStirng = 0
        var numberOfNumber = 0
        var numberOfBool = 0
        var numberOfObject = 0
        var numberOfArray = 0
        
        for data in array {
            switch data.type() {
            case .string: numberOfStirng += 1
            case .number: numberOfNumber += 1
            case .bool: numberOfBool += 1
            case .object: numberOfObject += 1
            case .array: numberOfArray += 1
            }
        }
        
        self.string = numberOfStirng
        self.number = numberOfNumber
        self.bool = numberOfBool
        self.object = numberOfObject
        self.array = numberOfArray
        self.all = self.string + self.number + self.bool + self.object + self.array
    }
    
    func numberOfString() -> Int {
        return self.string
    }
    
    func numberOfNumber() -> Int {
        return self.number
    }
    
    func numberOfBool() -> Int {
        return self.bool
    }
    
    func numberOfObject() -> Int {
        return self.object
    }
    
    func numberOfArray() -> Int {
        return self.array
    }
    
    func numberOfAll() -> Int {
        return self.all
    }
}
