//
//  JSONValueContainable.swift
//  JSONParser
//
//  Created by BLU on 2019. 6. 6..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

protocol TypeCountable {
    var dataTypes: [String: Int] { get }
}

extension Array: JSONValue, TypeCountable where Element == JSONValue {
    var typeDescription: String {
        return "배열"
    }
    var dataTypes: [String: Int] {
        var dataTypes = [String: Int]()
        for item in self {
            dataTypes[item.typeDescription] = (dataTypes[item.typeDescription] ?? 0) + 1
        }
        return dataTypes
    }
}

extension Dictionary: JSONValue, TypeCountable where Key == String, Value == JSONValue {
    var typeDescription: String {
        return "객체"
    }
    var dataTypes: [String: Int] {
        var dataTypes = [String: Int]()
        for item in self.values {
            dataTypes[item.typeDescription] = (dataTypes[item.typeDescription] ?? 0) + 1
        }
        return dataTypes
    }
}
