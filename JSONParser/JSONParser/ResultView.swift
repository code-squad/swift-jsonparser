//
//  ResultView.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 3. 13..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct ResultView {
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
    
    private func countOfNumber() -> String {
        guard self.number == 0 else { return "숫자 \(self.number)개" }
        return ""
    }
    
    private func countOfString() -> String {
        guard self.string == 0 else { return "문자열 \(self.string)개" }
        return ""
    }
    
    private func countOfBool() -> String {
        guard self.bool == 0 else { return "부울 \(self.bool)개" }
        return ""
    }
    
    private func countOfArray() -> String {
        guard self.array == 0 else { return "배열 \(self.array)개" }
        return ""
    }
    
    private func countArrayOfArray() -> String {
        guard self.arrayOfarray == 0 else { return "배열 \(self.arrayOfarray)개" }
        return ""
    }
    
    private func countOfObject() -> String {
        guard self.object == 0 else { return "객체 \(self.object)개" }
        return ""
    }
    
    func resultMessage(_ data: JSONData) {
        if data is Dictionary<String, Any> {
            let objectDataCount = self.number + self.string + self.bool + self.array
            print("총 \(objectDataCount)개의 객체 데이터 중에 \(countOfNumber()) \(countOfString()) \(countOfBool()) \(countOfArray())가 포함되어 있습니다")
        } else if data is ArrayData {
            let arrayDataCount = self.arrayOfarray + self.object
            print("총 \(arrayDataCount)개의 배열 데이터 중에 \(countArrayOfArray()) \(countOfObject())가 포함되어 있습니다.")
        }
    }
    
}


