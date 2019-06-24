//
//  JSONDataCount.swift
//  JSONParser
//
//  Created by JieunKim on 06/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Counter {
    static func count(jsonData: [JSONDataType]) -> [String: Int] {
        var counts: [String: Int] = [:]
        for item in jsonData {
            counts[item.typeDescription] = (counts[item.typeDescription] ?? 0) + 1
        }
        return counts
    }
    
    
    static func objectCount(object: [String: JSONDataType]) -> [String: Int] {
        var counts: [String: Int] = [:]
        for value in object.values {            counts[value.typeDescription] = (counts[value.typeDescription] ?? 0) + 1
        }
        return counts
    }
}
