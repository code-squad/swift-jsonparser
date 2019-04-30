//
//  MessageMaker.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/29/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct MessageMaker {
    static func makeMessage (_ json: [JsonType]) -> [String: Int] {
        var intCount = 0
        var boolCount = 0
        var stringCount = 0
        var message = [String: Int]()
        
        for value in json {
            switch value {
            case .int: intCount += 1
            case .bool: boolCount += 1
            case .string: stringCount += 1
            }
        }
        
        message["총"] = json.count
        if stringCount > 0 { message["문자열"] = stringCount }
        if intCount > 0 { message["숫자"] = intCount }
        if boolCount > 0 { message["부울"] = boolCount }
        
        return message
    }
}
