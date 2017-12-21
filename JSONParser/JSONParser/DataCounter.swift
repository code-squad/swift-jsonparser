//
//  File.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct DataCounter {
    func countNumberOfData(_ userData : Any) -> MyCount {
        if userData is [String : Any] {
            return countNumberOfObject(userData as! [String : Any])
        }
        return countNumbersOfArray(userData as! [Any])
    }
    
    private func countNumberOfObject(_ userData : [String : Any]) -> MyCount {
        var myCount : MyCount = MyCount()
        for oneData in userData {
            switch oneData.value {
            case is String : myCount.stringVal += 1
            case is Int : myCount.numberVal += 1
            case is Bool : myCount.boolVal += 1
            default : break
            }
        }
        myCount.objectVal = myCount.boolVal + myCount.numberVal + myCount.stringVal
        return myCount
    }
    
    private func countNumbersOfArray(_ userData : [Any]) -> MyCount {
        var myCount : MyCount = MyCount()
        for oneData in userData {
            switch oneData {
            case is String : myCount.stringVal += 1
            case is Int : myCount.numberVal += 1
            case is Bool : myCount.boolVal += 1
            default : myCount.objectVal += 1
            }
        }
        return myCount
    }
}
