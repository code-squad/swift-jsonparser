//
//  TypeChecker.swift
//  JSONParser
//
//  Created by 이동영 on 11/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct TypeChecker {
    
    func check(_ string:String,type:RegexPatterns) throws -> Bool {
        let regex = try type.getRegex()
        guard let match = regex.firstMatch(in: string, options: [], range: NSRange.init(0..<string.count)) else {
            return false
        }
        let matchString = NSString.init(string: string).substring(with: match.range)
        
        return string == matchString
    }
    
}
