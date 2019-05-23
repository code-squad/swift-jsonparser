//
//  Validation.swift
//  JSONParser
//
//  Created by hw on 07/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation


struct Validation {
    
    static func checkInvalidJsonObjectFormat(_ input: String) -> Bool{
        var isJsonObject = true
        isJsonObject &= checkPrefixSuffixFormat(input)
        isJsonObject &= checkJsonObjectKeyValueFormat(input)
        return isJsonObject
    }
    
    static private func checkPrefixSuffixFormat(_ input: String) -> Bool {
        var isJsonObject = true
        isJsonObject &= input.hasPrefix("{") && input.hasSuffix("}")
        return isJsonObject
    }
    
    static private func checkJsonObjectKeyValueFormat(_ input: String) -> Bool {
        var isJsonObject = true
        let filterPattern = ["{","}"]
        let removeFirstAndLastCharacter = input.filter{(value) in return !filterPattern.contains(String(value))}
        let keyValuePreSeperated = removeFirstAndLastCharacter.components(separatedBy: ",").map{ (value) in return //
            String(value).components(separatedBy: ":").map{value in return String(value)}}
        for element in keyValuePreSeperated {
            isJsonObject &= element.count == 2 ? true : false
        }
        return isJsonObject
    }
    
    static func checkInvalidJsonArrayFormat (_ input : String) throws  {
        var isValid: Bool = true
        /// array check
        isValid &= isJsonArrayFormat(input)
        /// object check
        isValid |= checkInvalidJsonObjectFormat(input)
        if !isValid{
            throw ErrorCode.invalidJsonFormat
        }
    }
    
    static func isJsonArrayFormat(_ input : String ) -> Bool {
        return checkStartSquareBracket(input) && checkEndSquareBracket(input)
    }

    static private func checkStartSquareBracket(_ input: String) -> Bool {
        return input[input.startIndex] == "[" ? true : false
    }
    
    static private func checkEndSquareBracket(_ input: String) -> Bool {
        return input[input.index(before: input.endIndex)] == "]" ? true : false
    }
}



