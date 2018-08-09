//
//  FormatValidationString.swift
//  JSONParser
//
//  Created by 이동건 on 09/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

extension String {
    var isValid: Bool {
        return !isNested && !isPairInArray
    }
    
    private var isNested: Bool {
        if let regex = try? NSRegularExpression(pattern: "\\{(?:.+?)?(?:\\{|\\[)(?:.+?)?(?:\\}|\\])(?:.+?)?\\}", options: .caseInsensitive) {
            let string = self as NSString
            return !regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).isEmpty
        }
        return false
    }
    
    private var isPairInArray: Bool {
        if let regex = try? NSRegularExpression(pattern: "\\[[a-z0-9\"\\s]+:[a-z0-9\"\\s]+\\]", options: .caseInsensitive) {
            let string = self as NSString
            return !regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).isEmpty
        }
        
        return false
    }
}
