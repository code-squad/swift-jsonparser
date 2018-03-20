//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 3. 20..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    
    func isValidInput(_ input: [String]) -> Bool {
        for data in input {
            if !data.contains("\"") && data == "true" || data == "false" || (Int.init(data) != nil) {
                return true
            }
        }
        return false
    }

}
