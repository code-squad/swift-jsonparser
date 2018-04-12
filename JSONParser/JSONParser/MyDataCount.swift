//
//  MyDataCount.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 4. 12..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct MyDataCount {
    private var number = 0
    private var string = 0
    private var bool = 0
    private var array = 0
    private var arrayOfarray = 0
    private var object = 0
    
    init(_ number: Int,_ string: Int,_ bool: Int,_ array: Int) {
        self.number = number
        self.string = string
        self.bool = bool
        self.array = array
    }
    
    init(_ arrayOfarray: Int,_ object: Int) {
        self.arrayOfarray = arrayOfarray
        self.object = object
    }
    
    func objectDataCount() -> Int {
        let object = self.number + self.string + self.bool + self.array
        return object
    }
    
    func arrayDataCount() -> Int {
        let array = self.arrayOfarray + self.object
        return array
    }
    
    func countOfNumber() -> String {
        guard self.number == 0 else { return "숫자 \(self.number)개" }
        return ""
    }
    
    func countOfString() -> String {
        guard self.string == 0 else { return "문자열 \(self.string)개" }
        return ""
    }
    
    func countOfBool() -> String {
        guard self.bool == 0 else { return "부울 \(self.bool)개" }
        return ""
    }
    
    func countOfArray() -> String {
        guard self.array == 0 else { return "배열 \(self.array)개" }
        return ""
    }
    
    func countArrayOfArray() -> String {
        guard self.arrayOfarray == 0 else { return "배열 \(self.arrayOfarray)개" }
        return ""
    }
    
    func countOfObject() -> String {
        guard self.object == 0 else { return "객체 \(self.object)개" }
        return ""
    }
}
