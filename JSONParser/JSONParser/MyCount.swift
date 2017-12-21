//
//  MyData.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 21..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct MyCount {
    
    var currentData : String = ""
    var stringVal : Int = 0
    var numberVal : Int = 0
    var boolVal : Int = 0
    var objectVal : Int = 0
    
}

protocol CountTypes {
    func countNumber() -> MyCount
}

extension Array : CountTypes {
    func countNumber() -> MyCount {
        var arrCount : MyCount = MyCount()
        arrCount.currentData = "array"
        for oneData in self {
            switch oneData {
            case is String : arrCount.stringVal += 1
            case is Int : arrCount.numberVal += 1
            case is Bool : arrCount.boolVal += 1
            case is [String : Any] : arrCount.objectVal += 1
            default : continue
            }
        }
        return arrCount
    }
}

extension Dictionary : CountTypes {
    
    func countNumber() -> MyCount {
        var dicCount : MyCount = MyCount()
        dicCount.currentData = "dictionary"
        for oneData in self {
            switch oneData.value {
            case is String : dicCount.stringVal += 1
            case is Int : dicCount.numberVal += 1
            case is Bool : dicCount.boolVal += 1
            default : continue
            }
        }
        dicCount.objectVal = dicCount.boolVal + dicCount.numberVal + dicCount.stringVal
        return dicCount
    }
    
}
