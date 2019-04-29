//
//  Converter.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/27/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Converter {
    static func inputToAny (_ valueEntered: String) throws -> [Any] {
        let input = valueEntered
        
        let InputSplited = try splitInput(input)
        let json = makeJson(InputSplited)
        
        return json
    }
    
    static private func splitInput (_ input: String) throws ->  [String] {
        var inputSplited = input.components(separatedBy: [",", " "])
        
        try verifyInput(inputSplited)
        
        inputSplited.removeFirst()
        inputSplited.removeLast()
        inputSplited = inputSplited.filter{$0 != ""}
        
        return inputSplited
    }
    
    static private func verifyInput (_ inputSplited: [String]) throws {
        if inputSplited.first != "[" || inputSplited.last != "]" {
            throw InputError.NonInputStandard
        }
        if inputSplited.count <= 2 {
            throw InputError.DataCountIsZero
        }
    }
    
    static private func makeJson (_ inputSplited: [String]) -> [Any] {
        var json = [Any]()
        
        for inputValue in inputSplited {
            if let number = Int(inputValue) {
                json.append(number)
            } else if inputValue == "true" {
                json.append(true)
            } else if inputValue == "false" {
                json.append(false)
            } else {
                json.append(inputValue)
            }
        }
        
        return json
    }
    
    static func makeMessage (_ json: [Any]) -> String {
        var intCount = 0
        var boolCount = 0
        var stringCount = 0
        var message = ""
        
        for value in json {
            switch value {
            case let value where value is Int: intCount += 1
            case let value where value is Bool: boolCount += 1
            default: stringCount += 1
            }
        }
        
        message = "총 \(json.count)개의 데이터 중에"
        if stringCount > 0 { message += " 문자열 \(stringCount)개" }
        if intCount > 0 { message += " 숫자 \(intCount)개" }
        if boolCount > 0 { message += " 부울 \(boolCount)개" }
        message += "가 포함되어 있습니다."
        
        return message
    }
}
