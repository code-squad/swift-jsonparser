//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 3. 20..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    
    func isValidInput(_ input: String) -> Bool {
        return input.contains("{") && input.contains("}") && input.contains(":")
    }
    
}

