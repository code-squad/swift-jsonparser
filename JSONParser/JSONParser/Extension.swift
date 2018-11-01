//
//  Extension.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

extension String {
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
    
    func isNumberForm() -> Bool {
        return !isEmpty && range(of: "^[^0-9]+$", options: .regularExpression) == nil
    }
    
    func isStringForm() -> Bool {
        return (hasPrefix("\"")) && (hasSuffix("\""))
    }
    
    func isBoolForm() -> Bool {
        return (uppercased() == "TRUE") || (uppercased() == "FALSE")
    }
}
