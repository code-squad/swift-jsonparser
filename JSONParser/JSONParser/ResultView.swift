//
//  ResultView.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 3. 13..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct ResultView {
    
    func countOfNumber (_ number: Int) -> String {
        guard number == 0 else { return "숫자 \(number)개" }
        return ""
    }
    
    func countOfString (_ string: Int) -> String {
        guard string == 0 else { return "문자열 \(string)개" }
        return ""
    }
    
    func countOfBool (_ bool: Int) -> String {
        guard bool == 0 else { return "부울 \(bool)개" }
        return ""
    }
    
    func countOfArray (_ array: Int) -> String {
        guard array == 0 else { return "배열 \(array)개" }
        return ""
    }
    
    func countArrayOfArray (_ array: Int) -> String {
        guard array == 0 else { return "배열 \(array)개" }
        return ""
    }
    
    func countOfObject (_ object: Int) -> String {
        guard object == 0 else { return "객체 \(object)개" }
        return ""
    }
    
    static func resultMessage(_ data: JSONData) {
        data.resultMessage()
    }
    
}


