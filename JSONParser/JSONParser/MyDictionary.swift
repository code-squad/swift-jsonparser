//
//  MyDictionary.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 21..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation


struct MyDictionary : MyData {

    var data : [String : Any] = [:]
    var stringVal: Int = 0
    var numberVal: Int = 0
    var boolVal: Int = 0
    var objectVal: Int = 0
    
    init(_ userData : [String : Any]) {
        self.data = userData
        
        for oneData in userData {
            switch oneData.value {
            case is String : self.stringVal += 1
            case is Int : self.numberVal += 1
            case is Bool : self.boolVal += 1
            default : continue
            }
        }
        self.objectVal = self.boolVal + self.numberVal + self.stringVal
    }
}
