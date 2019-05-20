//
//  MessageMaker.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/29/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct MessageMaker {
    static func makeMessage (_ json: JsonType) -> ([JsonTypeName: Int], JsonTypeName) {
        if case JsonType.object(_) = json {
            return (getEachTypeCountFromObject(json), JsonTypeName.object)
        }
        
        return (getEachTypeCountFromArray(json), JsonTypeName.array)
    }
    
    static private func getEachTypeCountFromArray (_ json: JsonType) -> [JsonTypeName : Int] {
        guard case let JsonType.array(array) = json else {
            return getEachTypeCountFromObject(json)
        }
        
        return getEachTypeCount(array)
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
    
    static private func getEachTypeCount (_ array: [JsonType]) -> [JsonTypeName : Int] {
        var eachTypeCount: [JsonTypeName : Int] = [JsonTypeName.total: array.count]
        
        for value in array {
            eachTypeCount[value.name]  = (eachTypeCount[value.name] ?? 0) + 1
        }
        
        return eachTypeCount
    }
}
