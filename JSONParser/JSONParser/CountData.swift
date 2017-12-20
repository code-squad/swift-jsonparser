//
//  File.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct CountData {
    func countNumberOfData(_ userData : Any) -> (stringVal : Int, numberVal : Int, boolVal : Int, objectVal : Int) {
        if userData is [String : Any] {
            return countNumberOfObject(userData as! [String : Any])
        }
        return countNumbersOfArray(userData as! [Any])
    }
    
    private func countNumberOfObject(_ userData : [String : Any]) -> (stringVal : Int, numberVal : Int, boolVal : Int, objectVal : Int) {
        var temp : (stringVal : Int, numberVal : Int, boolVal : Int, objectVal : Int) = (0,0,0,0)
        for oneData in userData {
            switch oneData.value {
            case is String : temp.stringVal += 1
            case is Int : temp.numberVal += 1
            case is Bool : temp.boolVal += 1
            default : break
            }
        }
        temp.objectVal = temp.boolVal + temp.numberVal + temp.stringVal
        return temp
    }
    
    private func countNumbersOfArray(_ userData : [Any]) -> (stringVal : Int, numberVal : Int, boolVal : Int, objectVal : Int) {
        var temp : (stringVal : Int, numberVal : Int, boolVal : Int, objectVal : Int) = (0,0,0,0)
        for oneData in userData {
            switch oneData {
            case is String : temp.stringVal += 1
            case is Int : temp.numberVal += 1
            case is Bool : temp.boolVal += 1
            default : temp.objectVal += 1
            }
        }
        return temp
    }
}
