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
    
    init (targetToCount countTarget : JSONData) {
        self.parsedJSONDataList = countTarget
    }
    
    func makeCountInfo () -> CountInfo {
        var countInfo = CountInfo(i:0,b:0,s:0,o:0,all:0)
        
        if case let JSONData.ArrayValue(countTarget) = parsedJSONDataList { // enum바인딩
           countInfo = countArrayValues(countTarget)
        }
        if case let JSONData.ObjectValue(countTarget) = parsedJSONDataList {
            countInfo = countObjectValues(countTarget)
        }
        return countInfo
    }
    
   private func countArrayValues(_ countTarget: [JSONData]) -> CountInfo{
        var countOfInt = 0
        var countOfBool = 0
        var countOfString = 0
        var countOfObject = 0
        let countOfJSONData = countTarget.count
        
        for datum in countTarget {
            switch datum {
            case .IntegerValue :
                countOfInt += 1
            case .BoolValue:
                countOfBool += 1
            case .StringValue :
                countOfString += 1
            case .ObjectValue :
                countOfObject += 1
            default :
                countOfString += 0
            }
        }
    return CountInfo(i:countOfInt, b:countOfBool, s:countOfString, o:countOfObject, all:countOfJSONData)
    }
    
    private func countObjectValues(_ countTarget: Dictionary<String, JSONData>) -> CountInfo {
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
        return CountInfo(i:countOfInt, b:countOfBool, s:countOfString, o:0, all:countOfJSONData)
    }
    
}
