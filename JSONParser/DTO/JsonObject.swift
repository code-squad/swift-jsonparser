//
//  JsonObject.swift
//  JSONParser
//
//  Created by hw on 16/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

typealias SortedKeyValueSet = [(offset: Int, element: (key: String, value: JsonParsable))]

struct JsonObject : JsonParsable {
    private (set) var keyValueSet : [String : JsonParsable]

    init(){
        self.keyValueSet = [String : JsonParsable]()
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
            var elements = [String]()
            var results = [String]()
            let sortedKeyValueSet = keyValueSet.enumerated().sorted(by: { ( pair1, pair2) -> Bool in
                return pair1.element.key < pair2.element.key
            })
            results.append("\(TokenSplitSign.curlyBracketStart.description)")
            for sortedPair in sortedKeyValueSet {
                elements.append("\t\(sortedPair.element.key) : \(sortedPair.element.value.description)")
            }
            results.append(elements.joined(separator: ",\n"))
            results.append("\(TokenSplitSign.curlyBracketEnd.description)")
            return results.joined(separator: "\n")
        }
    }
}
