//
//  Converter.swift
//  JSONParser
//
//  Created by 이동영 on 11/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Converter {
    static let separator = ","
    
    static func convert(string:String) throws -> [String] {
        let values = try Converter.getValues(string)
        let stringArray = values.components(separatedBy: self.separator )
        guard stringArray.count != 0 else {
            throw Exception.wrongFormat
        }
        return stringArray
    }
    
    static func getValues(_ string:String) throws -> String {
        guard try TypeChecker().check(string, type: .Array) else {
            return string
        }
        let unnecessaryCharacters:[Character] = ["[","]"," "]
        return string.filter{ !unnecessaryCharacters.contains($0) }
    }
}
