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
        let typeName = getTypeName(eachTypeCount)
        
        if eachTypeCount["객체"] == 1 && eachTypeCount.count == 2 {
            eachTypeCount = getEachTypeCountFromObject(json[0])
        } else {
           eachTypeCount["총"] = json.count
        }
        
        return (eachTypeCount, typeName)
    }
    
    static private func getEachTypeCount (_ json: [JsonType]) -> [String : Int] {
        var eachTypeCount: [String : Int] = ["총": json.count]
        
        for value in json {
            eachTypeCount[value.koreanName] = (eachTypeCount[value.koreanName] ?? 0) + 1
        }
        
        return eachTypeCount
    }
    
    static private func getEachTypeCountFromObject (_ json: JsonType) -> [String : Int] {
        var objectValues = [JsonType]()
        
        switch json {
        case .bool(_): break
        case .int(_): break
        case .string(_): break
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
