//
//  ValueCounter.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct ValueCounter {
    var parsedJSONDataList : JSONData
    
    init (_ data : JSONData) {
        self.parsedJSONDataList = data
    }
    
    func makeCountInfo () -> CountInfo {
        var countInfo = CountInfo(0,0,0,0)
        
        if case let JSONData.ArrayValue(countTarget) = parsedJSONDataList { // enum바인딩
           countInfo = countArrayValues(countTarget)
        }
        if case let JSONData.ObjectValue(countTarget) = parsedJSONDataList {
            countInfo = countObjectValues(countTarget)
        }
        return countInfo
    }
    
    func countArrayValues(_ countTarget: [JSONData]) -> CountInfo{
        var countOfInt = 0
        var countOfBool = 0
        var countOfString = 0
        let countOfJSONData = countTarget.count
        
        for datum in countTarget {
            switch datum {
            case .IntegerValue :
                countOfInt += 1
                
            case .BoolValue:
                countOfBool += 1
                
            case .StringValue :
                countOfString += 1
                
            default :
                countOfString += 0
            }
        }
        return CountInfo(countOfInt, countOfBool, countOfString, countOfJSONData)
    }
    
    func countObjectValues(_ countTarget: Dictionary<String, JSONData>) -> CountInfo {
        var countOfInt = 0
        var countOfBool = 0
        var countOfString = 0
        let countOfJSONData = countTarget.count
        
        for datum in countTarget.values {
            switch datum {
            case .IntegerValue :
                countOfInt += 1
                
            case .BoolValue:
                countOfBool += 1
                
            case .StringValue :
                countOfString += 1
                
            default :
                countOfString += 0
            }
        }
        return CountInfo(countOfInt, countOfBool, countOfString, countOfJSONData)
    }
    
}


