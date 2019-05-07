//
//  MessageMaker.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/29/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct MessageMaker {
    static func makeMessage (_ json: [JsonType]) -> ([String: Int], String) {
        var eachTypeCount = getEachTypeCount(json)
        let typeName: String
        
        typeName = getTypeName(eachTypeCount)
        if eachTypeCount["객체"] == 1 && eachTypeCount.count == 2 {
            eachTypeCount = getEachTypeCountFromObject(json[0])
        } else {
           eachTypeCount["총"] = json.count
        }
        
        return (eachTypeCount, typeName)
    }
    
    static private func getEachTypeCount (_ json: [JsonType]) -> [String : Int] {
        var eachTypeCount: [String : Int] = ["총": json.count]
        var intCount = 0; var boolCount = 0; var stringCount = 0; var objectCount = 0
        
        for value in json {
            switch value {
            case .int: intCount += 1; eachTypeCount["숫자"] = intCount
            case .bool: boolCount += 1; eachTypeCount["부울"] = boolCount
            case .string: stringCount += 1; eachTypeCount["문자열"] = stringCount
            case .object(_): objectCount += 1; eachTypeCount["객체"] = objectCount
            }
        }
        
        return eachTypeCount
    }
    
    static private func getEachTypeCountFromObject (_ json: JsonType) -> [String : Int] {
        var objectValues = [JsonType]()
        
        switch json {
        case .int(_): break
        case .string(_): break
        case .bool(_): break
        case let .object(object):
            for value in object.values {
                objectValues.append(value)
            }
        }
        return getEachTypeCount(objectValues)
    }
    
    static private func getTypeName (_ eachTypeCount: [String: Int]) -> String {
        if eachTypeCount["객체"] == 1 && eachTypeCount.count == 2 {
            return "객체"
        } else if eachTypeCount["숫자"] ?? 0 == 0 && eachTypeCount["부울"] ?? 0 == 0 && eachTypeCount["문자열"] ?? 0 == 0 && eachTypeCount["객체"] ?? 0 > 1 {
            return "배열"
        } else {
            return ""
        }
    }
}
