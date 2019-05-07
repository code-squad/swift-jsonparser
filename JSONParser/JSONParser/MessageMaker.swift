//
//  MessageMaker.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/29/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct MessageMaker {
    static func makeMessage (_ json: [JsonType]) -> ([JsonTypeName: Int], JsonTypeName) {
        var eachTypeCount = getEachTypeCount(json)
        let typeName: JsonTypeName
        
        typeName = getTypeName(eachTypeCount)
        if eachTypeCount[JsonTypeName.object] == 1 && eachTypeCount.count == 2 {
            eachTypeCount = getEachTypeCountFromObject(json[0])
        } else {
           eachTypeCount[JsonTypeName.total] = json.count
        }
        
        return (eachTypeCount, typeName)
    }
    
    static private func getEachTypeCount (_ json: [JsonType]) -> [JsonTypeName : Int] {
        var eachTypeCount: [JsonTypeName : Int] = [JsonTypeName.total: json.count]
        var intCount = 0
        var boolCount = 0
        var stringCount = 0
        var objectCount = 0
        
        for value in json {
            switch value {
            case .int: intCount += 1; eachTypeCount[JsonTypeName.int] = intCount
            case .bool: boolCount += 1; eachTypeCount[JsonTypeName.bool] = boolCount
            case .string: stringCount += 1; eachTypeCount[JsonTypeName.stirng] = stringCount
            case .object(_): objectCount += 1; eachTypeCount[JsonTypeName.object] = objectCount
            }
        }
        
        return eachTypeCount
    }
    
    static private func getEachTypeCountFromObject (_ json: JsonType) -> [JsonTypeName : Int] {
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
    
    static private func getTypeName (_ eachTypeCount: [JsonTypeName: Int]) -> JsonTypeName {
        if eachTypeCount[JsonTypeName.object] == 1 && eachTypeCount.count == 2 {
            return JsonTypeName.object
        } else if eachTypeCount[JsonTypeName.int] ?? 0 == 0 && eachTypeCount[JsonTypeName.bool] ?? 0 == 0 && eachTypeCount[JsonTypeName.stirng] ?? 0 == 0 && eachTypeCount[JsonTypeName.object] ?? 0 > 1 {
            return JsonTypeName.array
        } else {
            return JsonTypeName.nothing
        }
    }
}
