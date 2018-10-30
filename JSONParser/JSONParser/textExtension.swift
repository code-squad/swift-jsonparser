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
    
    // 입력 문자열의 따옴표 제거
    var removeQuotation: String {
        return self.replacingOccurrences(of: "\"", with: "")
    }
    
    // 콤마(,)로 배열로 변환 & 공백(blank) 제거
    var separateByComma: [String] {
        return self.split(separator: ",").map {String($0).trimmingCharacters(in: .whitespaces)}
    }
    
    // 문자열인지 확인 & 부울 타입 제외
    var isString: Bool {
        return self.range(of: "[^ a-zA-Z]", options: .regularExpression) == nil && !self.isBoolean && self != String()
    }
    
    // 숫자인지 확인
    var isNumeric: Bool {
        return self.range(of: "[^ 0-9]", options: .regularExpression) == nil && self != String()
    }
    
    // 부울인지 확인
    var isBoolean: Bool {
        guard Bool(self) != nil else { return false }
        return true
    }
}
