//
//  StringExtension.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 17..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

extension String {
    func matchPatterns(pattern regex: String) throws -> Bool {
        guard let regex = try? NSRegularExpression(pattern: regex) else {
            throw JSONError.notDataConversation
        }
        
        return regex.matches(in: self, range: NSRange(self.startIndex..., in: self)).count > 0
    }
    
    func splitUnits(seperator _seperator: Character) -> [String] {
        return self.split(separator: _seperator).map({ (s: String.SubSequence) -> String in
            return String(s)
        })
    }
}

extension String: JSONDataMaker {
    func makeJSONData() -> JSONData {
        return JSONData.string(self)
    }
}
