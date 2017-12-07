//
//  ObjectCounter.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 7..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct ObjectCounter {
    
    var countOfInt: Int = 0
    var countOfString: Int = 0
    var countOfBool: Int = 0
    
    func checkTypeOfValues(_ checkTargets: Dictionary<String,String>) -> CountingInfo {
        let countOfValue = checkTargets.count
        var countOfInt: Int = 0
        var countOfString: Int = 0
        var countOfBool: Int = 0
        
        for checkTarget in checkTargets {
            
            if Bool(checkTarget.value) != nil {
                countOfBool += 1
                continue
            } else if Int(checkTarget.value) != nil {
                countOfInt += 1
                continue
            }
            countOfString += 1
        }
        
        return CountingInfo(countOfValue, countOfInt, countOfString, countOfBool)
    }
    
}
