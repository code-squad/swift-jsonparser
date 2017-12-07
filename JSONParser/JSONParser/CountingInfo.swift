//
//  CountInfo.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 5..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct CountingInfo {
    var countOfValue: Int = 0
    private var countOfInt: Int = 0
    private var countOfString: Int = 0
    private var countOfBool: Int = 0
    
    init (_ countOfValue: Int, _ countOfInt: Int, _ countOfString: Int, _ countOfBool: Int) {
        self.countOfValue = countOfValue
        self.countOfInt = countOfInt
        self.countOfString = countOfString
        self.countOfBool = countOfBool
    }

    func makeResultMessage () -> String{
        var resultMessage = ""
        
        if countOfInt != 0 {
            resultMessage.append("숫자 \(countOfInt)개 ")
        }
        if countOfString != 0 {
            resultMessage.append("문자열 \(countOfString)개 ")
        }
        if countOfBool != 0 {
            resultMessage.append("부울 \(countOfBool)개 ")
        }
        return resultMessage
    }
    
}
