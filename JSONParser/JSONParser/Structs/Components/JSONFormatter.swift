//
//  JSONFormatter.swift
//  JSONParser
//
//  Created by 이동영 on 24/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONFormatter {
    
    static func stringfy(value: JsonValue, depth: Int = 0) -> String {
        var result: String
        
        switch value {
        case let list as JsonList:
            result = stringfy(list,depth: depth+1)
        case let object as JsonObject:
            result = stringfy(object,depth: depth+1)
        case let string as String:
            result = "\"\(string)\""
        default:
            result = "\(value)"
        }
        return result
    }
    
    private static func stringfy(_ list: JsonList, depth: Int) -> String {
        let elements = list.map {
            stringfy(value: $0,depth: depth)
        }
        return wrapList(elements.joined(separator: ", "), depth: depth-1)
    }
    
    private static func stringfy(_ object: JsonObject, depth: Int) -> String {
        let elements = object.map {
            "\(getWs(depth: depth))\"\($0.key)\" : \(stringfy(value: $0.value,depth: depth))"
        }
        return wrapObject(elements.joined(separator: ",\n"), depth: depth-1)
    }
    
    private static func wrapList(_ elements: String, depth: Int) -> String {
        let end = depth == 0 ? "\n" : ""
        return "\(getWs(depth: depth))[ \(elements)\(end) ]"
    }
    
    private static func wrapObject(_ elements: String ,depth: Int) -> String {
        return "{\n\(elements)\n\(getWs(depth: depth))}"
    }
    
    private static func getWs(depth: Int) -> String {
        return String.init(repeating: "\t", count: depth)
    }
    
}
