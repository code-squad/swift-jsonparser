//
//  ValueCounter.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 5..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct ValueCounter {
    
    func checkTypeOfValue (_ values: [String]) -> CountingInfo {
        var countOfInt: Int = 0
        var countOfString: Int = 0
        var countOfBool: Int = 0
        var valueList : [AnyObject] = []
        
        for value in values {
            if let boolValue = Bool(value) {
                valueList.append(boolValue as AnyObject)
                countOfBool += 1
                continue
            } else if let intValue = Int(value) {
                valueList.append(intValue as AnyObject)
                countOfInt += 1
                continue
            }
                valueList.append(value as AnyObject)
                countOfString += 1
        }
        let countOfValue = valueList.count
        return CountingInfo(countOfValue, countOfInt, countOfString, countOfBool)
    }
    
}
