//
//  StringExtension.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 17..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

extension String {
    func matchPatterns(pattern regex: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: regex) else {
            return false
        }
        
        return regex.matches(in: self, range: NSRange(self.startIndex..., in: self)).count > 0
    }
    
    func splitUnits() -> [String] {
        return self.split(separator: ",").map({ (s: String.SubSequence) -> String in
            return String(s).trimmingCharacters(in: .whitespaces)
        })
    }
}

extension String: JSONDataMaker {
    func makeJSONData() -> JSONData {
        return JSONData.string(self)
    }
}
