//
//  Extensions.swift
//  JSONParser
//
//  Created by 윤지영 on 18/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

extension String {
    func hasSideSquareBrackets() -> Bool {
        return (self.count > 1 && self.first == "[" && self.last == "]")
    }

    func hasSideCurlyBrackets() -> Bool {
        return (self.count > 1 && self.first == "{" && self.last == "}")
    }
    
    func hasDoubleQuotation() -> Bool {
        return (self.count > 1 && self.first == "\"" && self.last == self.first)
    }
    
    func trimWhiteSpaces() -> String {
        return self.trimmingCharacters(in: CharacterSet(charactersIn: " "))
    }
    
    func trimSquareBrackets() -> String {
        return self.trimmingCharacters(in: CharacterSet(charactersIn: "[]"))
    }
    
    func trimCurlyBrackets() -> String {
        return self.trimmingCharacters(in: CharacterSet(charactersIn: "{}"))
    }
    
    func trimDoubleQuotation() -> String {
        return self.trimmingCharacters(in: CharacterSet(charactersIn: "\""))
    }
    
    func splitByComma() -> [String] {
        return self.split(separator: ",").map { String($0) }
    }
    
    func splitByColon() -> [String] {
        return self.split(separator: ":").map { String($0) }
    }
}
