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
        let typeName = getTypeName(eachTypeCount)
        
        if eachTypeCount[JsonTypeName.object] == 1 && eachTypeCount.count == 2 {
            eachTypeCount = getEachTypeCountFromObject(json[0])
        } else {
           eachTypeCount[JsonTypeName.total] = json.count
        }
        
        return (eachTypeCount, typeName)
    }
    
    static private func getEachTypeCount (_ json: [JsonType]) -> [JsonTypeName : Int] {
        var eachTypeCount: [JsonTypeName : Int] = [JsonTypeName.total: json.count]
        
        for value in json {
            eachTypeCount[value.name]  = (eachTypeCount[value.name] ?? 0) + 1
        }
        
        return eachTypeCount
    }
    
    static private func getEachTypeCountFromObject (_ json: JsonType) -> [JsonTypeName : Int] {
        var objectValues = [JsonType]()
        
        if case let JsonType.object(object) = json {
            for value in object.values {
                objectValues.append(value)
            }
        }
        
        return getEachTypeCount(objectValues)
    }
    
    static private func getTypeName (_ eachTypeCount: [JsonTypeName: Int]) -> JsonTypeName {
        if eachTypeCount[JsonTypeName.object] == 1 && eachTypeCount.count == 2 {
            return JsonTypeName.object
        } else if eachTypeCount[JsonTypeName.int] ?? 0 == 0 && eachTypeCount[JsonTypeName.bool] ?? 0 == 0 && eachTypeCount[JsonTypeName.string] ?? 0 == 0 && eachTypeCount[JsonTypeName.object] ?? 0 > 1 {
            return JsonTypeName.array
        } else {
            return JsonTypeName.nothing
        }
    }
}
