//
//  JsonSyntaxChecker.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 14..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct SyntaxChecker {
    enum ErrorMessage: String, Error {
        case ofNoSquareBracket = "입력값이 유효하지 않습니다."
    }
     static func makeValidString (values: String) throws -> Array<String> {
        guard try checkIsValidForJson(values)  else { throw ErrorMessage.ofNoSquareBracket }
        let validvalues = findJsonString(from: values)
        return validvalues
    }
    
    private static func checkIsValidForJson (_ stringValue: String) throws -> Bool{
        let jsonPattern = "\\[.+,?\\]"
        do {
            let regex = try NSRegularExpression(pattern: jsonPattern)
            let results = regex.matches(in: stringValue, range: NSRange(location: 0, length: stringValue.count))
            return !results.isEmpty
        } catch {
            throw error
        }
    }
    
    private static func findJsonString (from validString: String) -> [String] {
        return validString.trimmingCharacters(in: ["[", "]"]).split(separator: ",").map{ String($0.trimmingCharacters(in: .whitespacesAndNewlines)) }
    }

}
