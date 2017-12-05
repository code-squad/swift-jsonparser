//
//  CountInfo.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 5..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct CountingInfo {
    var valueNum: Int = 0
    var intNum: Int = 0
    var stringNum: Int = 0
    var boolNum: Int = 0
    
    init (_ valueNum: Int, _ intNum: Int, _ stringNum: Int, _ boolNum: Int) {
        self.valueNum = valueNum
        self.intNum = intNum
        self.stringNum = stringNum
        self.boolNum = boolNum
    }

    func makeResultMessage () -> String{
        var resultMessage = ""
        
        if intNum != 0 {
            resultMessage.append("숫자 \(intNum)개 ")
        }
        if stringNum != 0 {
            resultMessage.append("문자열 \(stringNum)개 ")
        }
        if boolNum != 0 {
            resultMessage.append("부울 \(boolNum)개 ")
        }
        return resultMessage
    }
    
}
