//
//  JSONData.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 3. 26..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

protocol JSONData {
    func resultView() -> ResultView
}

extension Dictionary: JSONData {
    
    func resultView() -> ResultView {
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
        return ResultView.init(number, string, bool, array)
        
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
    func resultView() -> ResultView {
        return ResultView.init(self.array, self.object)
    }
}
