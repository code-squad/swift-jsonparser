//
//  MyArray.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 21..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct  MyArray : MyData {
    
    var data : [Any] = []
    var stringVal: Int = 0
    var numberVal: Int = 0
    var boolVal: Int = 0
    var objectVal: Int = 0
    
    init(_ userData : [Any]) {
        self.data = userData
        for oneData in self.data {
            switch oneData {
            case is String : self.stringVal += 1
            case is Int : self.numberVal += 1
            case is Bool : self.boolVal += 1
            case is MyDictionary : self.objectVal += 1
            default : continue
            }
        }
    }
}
