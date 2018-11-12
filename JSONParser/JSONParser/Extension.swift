//
//  Extension.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

extension String {
    func removeDoubleQuotationMarks() -> String {
        return trimmingCharacters(in: ["\"","\""])
    }
    
    private func removeSquareBracket() -> String {
        return trimmingCharacters(in: ["[","]"])
    }
    
    private func removeSpace() -> String {
        return replacingOccurrences(of: " ", with: "")
    }
    
    func extractData() -> [String] {
        let removedSquareBracket = self.removeSquareBracket()
        let removedSpace = removedSquareBracket.removeSpace()
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
        return "none"
    }
}

extension Array {
    func numberByType() -> NumberByType {
        var numberOfStirng = 0
        var numberOfNumber = 0
        var numberOfBool = 0
        
        for data in self {
            numberOfStirng += data is String ? 1 : 0
            numberOfNumber += data is Double ? 1 : 0
            numberOfBool += data is Bool ? 1 : 0
        }
        return NumberByType.init(string: numberOfStirng,
                                 number: numberOfNumber,
                                 bool: numberOfBool)
    }
}
