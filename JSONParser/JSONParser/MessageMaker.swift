//
//  MessageMaker.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/29/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct MessageMaker {
    static func makeMessage (_ json: [JsonType]) -> String {
        var intCount = 0
        var boolCount = 0
        var stringCount = 0
        var message = ""
        
        for value in json {
            switch value {
            case let value where value is JsonType.int: intCount += 1
            case let value where value is JsonType.bool: boolCount += 1
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
