//
//  File.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct CountData {
    
     func countNumberOfObjects(userData : [Any]) -> (stringVal : Int, numberVal : Int, boolVal : Int) {
        var temp : (stringVal : Int, numberVal : Int, boolVal : Int) = (0,0,0)
        for oneData in userData {
            switch oneData {
            case is String : temp.stringVal += 1
            case is Int : temp.numberVal += 1
            case is Bool : temp.boolVal += 1
            default : break
            }
        }
        return temp
    }
}
