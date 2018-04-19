//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 3. 20..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    
    func isValidFirstString(_ inputValue: String) -> Bool {
        return inputValue.hasPrefix("[") || inputValue.hasPrefix("{")
    }
    
    func isValidLastString(_ inputValue: String) -> Bool {
        return inputValue.hasSuffix("]") || inputValue.hasSuffix("}")
    }

    func isValidOfDictionary(_ dictionary: [String:Any]) -> Bool {
        for (key, value) in dictionary {
            
            if value is Int || value is Bool && key.hasPrefix("\"") && key.hasSuffix("\"") {
                continue
            } else if value is String {
                let stringValue = value as! String
                if key.hasPrefix("\"") && key.hasSuffix("\"") && stringValue.hasPrefix("\"") && stringValue.hasSuffix("\"") {
                    continue
                } else {
                    return false
                }
            }
        }
        return true
    }

}


