//
//  JSONValueType.swift
//  JSONParser
//
//  Created by CHOMINJI on 19/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol PreetyFormat {
    var serialized: String { get }
}

extension PreetyFormat {
    var serialized: String {
        return "\(self)"
    }
}

protocol JSONValueType: PreetyFormat {
   var typeDescription: String { get }
}

protocol TypeCountable {
    var totalCount: Int { get }
    var typeCounts: [String: Int] { get }
}

extension String: JSONValueType {
    var typeDescription: String {
        return "문자열"
    }
}

typealias Number = Int
extension Number: JSONValueType {
    var typeDescription: String {
        return "숫자"
    }
}

extension Bool: JSONValueType {
    var typeDescription: String {
        return "부울"
    }
}

typealias JSONContainerType = JSONValueType & TypeCountable

typealias Object = [String: JSONValueType]
extension Object: JSONContainerType, PreetyFormat {
    var typeDescription: String {
        return "객체"
    }
    
    var totalCount: Int {
        return self.count
    }
    
    var typeCounts: [String: Int] {
        var counts: [String: Int] = [:]
        for (_, value) in self {
            counts[value.typeDescription, default: 0] += 1
        }
        return counts
    }
    
    var serialized: String {
        var jsonString = "{\n\t"
        jsonString += self.map{ (key, value) in
            "\(key.serialized): \(value.serialized)"
            }.joined(separator: ",\n\t")
        jsonString += "\n}"
        return jsonString
    }
}

typealias JSONArray = [JSONValueType]
extension JSONArray: JSONContainerType, PreetyFormat {
    var typeDescription: String {
        return "배열"
    }
    
    var totalCount: Int {
        return self.count
    }
    
    var typeCounts: [String: Int] {
        var counts: [String: Int] = [:]
        for data in self {
            counts[data.typeDescription, default: 0] += 1
        }
        return counts
    }
    
    var serialized: String {
        var jsonString = "["
        jsonString += self.map { (element) in
            let data = element as? Object
            let dataString = (data != nil) ? "\(data!.nestedSerialized)" : "\(element.serialized)"
            return dataString
            }.joined(separator: ", ")
        jsonString += "]"
        
        return jsonString
    }
    
   
}
