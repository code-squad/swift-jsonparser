//
//  Extension.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

extension String {
    private func regex(pattern:String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {return []}
        
        let range = NSRange(self.startIndex..., in: self)
        let matches = regex.matches(in: self, options: [], range: range)
        
        return matches.map {
            let range = Range($0.range, in: self)!
            return String(self[range])
        }
    }
    
    func removeDoubleQuotationMarks() -> String {
        return trimmingCharacters(in: ["\"","\""])
    }
    
    func seperateByColon() -> [String] {
        return split(separator: ":").map{String($0)}
    }

    private func removeSpace() -> String {
        return replacingOccurrences(of: " ", with: "")
    }
    
    func extractData() -> [String] {
        let removedSpace = self.removeSpace()
        return removedSpace.split(separator: ",").map{String($0)}
    }
    
    func isTrue() -> Bool {
        return uppercased() == "TRUE"
    }
    
    private func isNumberForm() -> Bool {
        return !isEmpty && range(of: "^[^0-9]+$", options: .regularExpression) == nil
    }
    
    private func isStringForm() -> Bool {
        return (hasPrefix("\"")) && (hasSuffix("\""))
    }
    
    private func isBoolForm() -> Bool {
        return (uppercased() == "TRUE") || (uppercased() == "FALSE")
    }
    
    private func isObject() -> Bool {
        return (hasPrefix("{")) && (hasSuffix("}"))
    }
    
    func isWhatForm() -> String {
        if isBoolForm() {
            return "bool"
        }
        if isStringForm() {
            return "string"
        }
        if isNumberForm() {
            return "number"
        }
        if isObject() {
            return "object"
        }
        return "none"
    }
    
    func isWhatCollectionType() -> Creator? {
        switch (self.first,self.last) {
        case ("[","]"):
            return ArrayCreator()
        case ("{","}"):
            return ObjectCreator()
        default:
            return nil
        }
    }
}
