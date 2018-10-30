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
    var removeBracket: String {
        return String(self.dropFirst().dropLast())
    }
    
    var removeQuotation: String {
        return self.replacingOccurrences(of: "\"", with: "")
    }
    
    var separateByComma: [String] {
        return self.split(separator: ",").map {String($0).trimmingCharacters(in: .whitespaces)}
    }
    
    var isString: Bool {
        return self.range(of: "[^ a-zA-Z]", options: .regularExpression) == nil && !self.isBoolean && self != String()
    }
    
    var isNumeric: Bool {
        return self.range(of: "[^ 0-9]", options: .regularExpression) == nil && self != String()
    }
    
    var isBoolean: Bool {
        guard Bool(self) != nil else { return false }
        return true
    }
}
