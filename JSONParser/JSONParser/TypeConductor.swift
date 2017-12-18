//
//  TypeConductor.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 17..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct TypeConductor {
    var inputValue : String

    init (_ inputValue: String?) {
        let inputValue = inputValue ?? ""
        self.inputValue = inputValue
    }
    
    func decideInputType() -> ParseTarget {
        if inputValue.hasPrefix("[") && inputValue.hasSuffix("]") {
            return MyArray(inputValue)
        }
        if inputValue.hasPrefix("{") && inputValue.hasSuffix("}") {
            return MyObject(inputValue)
        }
        return MyArray("")
    }
    
}
