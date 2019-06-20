//
//  Parser.swift
//  JSONParser
//
//  Created by JH on 08/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Parser {
    
    ///입력받은 값을 타입확인하고 해당하는 타입으로 변환해서 반환
    func parseValue(input: String) -> Any {
        if let stringToken = parseString(input: input) {
            return stringToken
        } else if let boolToken = parseBool(input: input) {
            return boolToken
        } else if let intToken = parseInt(input: input) {
            return intToken
        }
        return "변환할수없는 값"
    }
    
    
    ///string타입 옵셔널 반환
    func parseString(input: String) -> String? {
        var input = input
        guard input.first == "\"" else {
            return nil
        }
        input.removeFirst()
        input.removeLast()
        return String(input)
    }
    ///Bool타입 옵셔널 반환
    func parseBool(input: String) -> Bool? {
        guard input == "true" || input == "false" else {
            return nil
        }
        return Bool(input)
    }
    ///Int타입 옵셔널 반환
    func parseInt(input: String) -> Int? {
        guard let int = Int(input) else {
            return nil
        }
        return int
    }
    
        
}
