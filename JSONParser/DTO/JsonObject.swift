//
//  JsonObject.swift
//  JSONParser
//
//  Created by hw on 16/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonObject : JsonParsable {
    private (set) var keyValueSet : [String : JsonValue]
    
    init(){
        self.keyValueSet = [String : JsonValue]()
    }
    
    init(keys: [String], values: [JsonValue]){
        self.keyValueSet = [String : JsonValue]()
        for index in 0..<keys.count{
            keyValueSet.updateValue(values[index], forKey: keys[index])
        }
    }

    mutating func add(key: String, value : JsonValue ){
        self.keyValueSet.updateValue(value, forKey: key)
    }
    
    func searchValue(key: String) throws -> JsonValue {
        guard let result = keyValueSet[key] else {
            throw ErrorCode.notFoundKey
        }
       return result
    }
    
    var description: String {
        get {
            let sortedKeyValueSet = keyValueSet.enumerated().sorted(by: { ( pair1, pair2) -> Bool in
                return pair1.element.key < pair2.element.key
            })
            var result = "{ "
            for sortedPair in sortedKeyValueSet {
                result += "\(sortedPair.element.key) : \(sortedPair.element.value.jsonValue.description), "
            }
            result.removeLast(2)
            result += " }"
            return result
        }
    }
}
