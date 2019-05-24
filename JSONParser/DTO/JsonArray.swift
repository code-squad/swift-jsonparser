//
//  JsonArray.swift
//  JSONParser
//
//  Created by hw on 14/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonArray : JsonParsable {
    
    private (set) var arrayList : [JsonValue]
    
    init(){
        self.arrayList = [JsonValue]()
    }
    
    init(_ input: [JsonParsable]){
        self.init()
        for index in 0..<input.count {
            arrayList.append(JsonValue(input[index]))
        }
    }
    
    mutating func add(value: JsonValue){
        self.arrayList.append(value)
    }
    
    var description: String {
        get {
            var result = "\(JsonBrackets.StartSquareBracket.rawValue) "
            for index in 0..<arrayList.count-1{
            result += " \(arrayList[index].jsonValue.description),"
            }
            result += " \(arrayList[arrayList.count-1].jsonValue.description) \(JsonBrackets.EndSquareBracket.rawValue)"
            return result
        }
    }
}
