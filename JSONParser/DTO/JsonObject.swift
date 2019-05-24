//
//  JsonObject.swift
//  JSONParser
//
//  Created by hw on 16/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonObject : JsonParsable {
    private (set) var keyValueSet : [String : JsonParsable]
    
    init(){
        self.keyValueSet = [String : JsonParsable]()
    }
    
    init(keys: [String], values: [JsonParsable]){
        self.keyValueSet = [String : JsonParsable]()
        for index in 0..<keys.count{
            keyValueSet.updateValue(values[index], forKey: keys[index])
        }
    }

    mutating func add(key: String, value : JsonParsable ){
        self.keyValueSet.updateValue(value, forKey: key)
    }
    
    func searchValue(key: String) throws -> JsonParsable {
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
            var result = "\(JsonBrackets.StartCurlyBrace.rawValue) "
            for sortedPair in sortedKeyValueSet {
                result += "\(sortedPair.element.key) : \(sortedPair.element.value.description), "
            }
            result.removeLast(2)
            result += " \(JsonBrackets.EndCurlyBrace.rawValue)"
            return result
        }
    }
}
