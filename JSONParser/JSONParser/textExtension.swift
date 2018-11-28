//
//  extension.swift
//  JSONParser
//
//  Created by 김장수 on 30/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

// 중복되는 코드를 extension을 이용해 묶음
extension String {
    
    // 대괄호를 제거
    var removeBracket: String {
        return String(self.dropFirst().dropLast())
    }
    
    // 문자열인지 확인 & 부울 타입 제외
    var isString: Bool {
        return self.first == "\"" && self.last == "\"" 
    }
    
    // 숫자인지 확인
    var isNumeric: Bool {
        return Int(self) != nil
    }
    
    // 부울인지 확인
    var isBoolean: Bool {
        return Bool(self) != nil
    }
    
    // 배열인지 확인
    var isArray: Bool {
        guard self.first == "[" && self.last == "]" else { return false }
        return true
    }
    
    // 객체인지 확인
    var isObject: Bool {
        guard self.first == "{" && self.contains(":") && self.last == "}" else { return false }
        return true
    }
}

extension Int {
    var calcBlank: String {
        if self == 1 {
            return "\t"
        }
        return String()
    }
}
