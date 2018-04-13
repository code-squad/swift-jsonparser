//
//  JSONData.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 3. 26..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

protocol JSONData {
    func countJSONData() -> MyDataCount
    func resultMessage(_ dataCount: MyDataCount) -> String
}

extension Dictionary: JSONData {
    
    func countJSONData() -> MyDataCount {
        var number = 0
        var string = 0
        var bool = 0
        var array = 0
        
        for i in self.values {
            if i is Int {
                number += 1
            } else if i is String {
                string += 1
            } else if i is Bool {
                bool += 1
            } else if i is Array<Any> {
                array += 1
            }
        }
        return MyDataCount.init(number, string, bool, array)
    }
    
    func resultMessage(_ dataCount: MyDataCount) -> String {
        return "총 \(dataCount.objectDataCount())개의 객체 데이터 중에 \(dataCount.countOfNumber()) \(dataCount.countOfString()) \(dataCount.countOfBool()) \(dataCount.countOfArray())가 포함되어 있습니다"
    }
    
}

struct ArrayData {
    var array = 0
    var object = 0
    init(array: Int, object: Int) {
        self.array = array
        self.object = object
    }
}

extension ArrayData: JSONData {
    
    func countJSONData() -> MyDataCount {
        return MyDataCount.init(self.array, self.object)
    }
    
    func resultMessage(_ dataCount: MyDataCount) -> String {
        return "총 \(dataCount.arrayDataCount())개의 배열 데이터 중에 \(dataCount.countArrayOfArray()) \(dataCount.countOfObject())가 포함되어 있습니다."
    }
    
}
