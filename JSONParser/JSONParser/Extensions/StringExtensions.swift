//
//  StringExtensions.swift
//  JSONParser
//
//  Created by 이동영 on 29/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

extension String {

    func isNumber() -> Bool {
        return Int(self) != nil
    }
    
    func isBool() -> Bool {
        return Bool(self) != nil
    }
    
    func isString() -> Bool {
        return self.first == "\"" && self.last == "\""
    }
    
    func isWhiteSpace() -> Bool {
        return self == " "
    }
    
    func isComma() -> Bool {
        return self == ","
    }
    
    func isDoubleQuotation() -> Bool {
        return self == "\""
    }
    
    func isLeftBraket() -> Bool {
        return self == "["
    }
    
    func isRightBraket() -> Bool {
        return self == "]"
    }
}
