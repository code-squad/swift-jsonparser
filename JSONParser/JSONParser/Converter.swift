//
//  Converter.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/27/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Converter {
    static func inputToAny (_ valueEntered: String) throws -> [JsonType] {
        let input = valueEntered
        
        let InputSplited = try splitInput(input)
        let json = JsonParser.makeJson(InputSplited)
        
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
}
