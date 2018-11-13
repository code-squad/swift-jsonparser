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
    
    // 콤마(,)로 배열로 변환 & 공백(blank) 제거
    var separateByComma: [String] {
        return self.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
    }
    
    // 콜론(:)으로 배열로 변환 & 공백(blank) 제거
    var separateByColumn: [String] {
        return self.split(separator: ":").map { String($0).trimmingCharacters(in: .whitespaces) }
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
}
