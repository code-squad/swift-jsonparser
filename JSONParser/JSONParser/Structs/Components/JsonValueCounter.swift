//
//  JsonValueCounter.swift
//  JSONParser
//
//  Created by 이동영 on 02/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonValueCounter: Counter {
    typealias T = JsonValue
    
    func count(target: JsonValue) -> Dictionary<String, Int> {
        var numOf = Dictionary<String, Int>()
        
        if let object = target as? JsonObject {
            numOf = self.count(in: object)
        }
        if let list = target as? JsonList {
            numOf = self.count(in: list)
        }
        return numOf
    }
    
    private func count(in object: JsonObject) -> Dictionary<String, Int> {
        var numOf = Dictionary<String, Int>()
        
        _ = object.map {
            numOf[$0.value.describeType()] = ( numOf[$0.value.describeType()] ?? 0 ) + 1
        }
        return numOf
    }
    
    private func count(in list: JsonList) -> Dictionary<String, Int> {
        var numOf = Dictionary<String, Int>()
        
        _ = list.map {
            numOf[$0.describeType()] = ( numOf[$0.describeType()] ?? 0 ) + 1
        }
        return numOf
    }
}
