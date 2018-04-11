//
//  JSONData.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 3. 26..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

protocol JSONData {
    func resultMessage()
}

extension Dictionary: JSONData {
    
    func resultMessage() {
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
        
        let resultView = ResultView()
        let numberMessage = resultView.countOfNumber(number)
        let stringMessage = resultView.countOfString(string)
        let boolMessage = resultView.countOfBool(bool)
        let arrayMessage = resultView.countOfArray(array)
        
        print("총 \(self.count)개의 객체 데이터 중에 \(numberMessage) \(stringMessage) \(boolMessage) \(arrayMessage)가 포함되어 있습니다")
        
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
    
    func resultMessage() {
        let resultView = ResultView()
        let arrayMessage = resultView.countArrayOfArray(self.array)
        let objectMessage = resultView.countOfObject(self.object)
        
        print("총 \(self.array + self.object)개의 배열 데이터 중에 \(arrayMessage) \(objectMessage)가 포함되어 있습니다.")
    }
}
