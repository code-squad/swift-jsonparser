//
//  JSONData.swift
//  JSONParser
//
//  Created by Elena on 24/12/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol JSONType {
    var typeName: String { get }
}

extension String: JSONType {
    var typeName: String {
        return "문자열"
    }
}

extension Int: JSONType {
    var typeName: String {
        return "숫자"
    }
}

extension Bool: JSONType {
    var typeName: String {
        return "부울"
    }
}

extension Dictionary: JSONType where Key == String, Value == JSONType {
    var typeName: String {
        return "객체"
    }
}

extension Array: JSONType where Element == JSONType {
    var typeName: String {
        return "배열"
    }
}

protocol JSONDataForm: JSONType {
    var totalCount: Int { get }
    func countType() -> [String: Int]
}

extension Dictionary: JSONDataForm where Key == String, Value == JSONType {
    var totalCount: Int {
        return self.count
    }
    
    func countType() -> [String : Int] {
        var typeCount: [String: Int] = [:]
        for value in self.values {
            typeCount[value.typeName] = (typeCount[value.typeName] ?? 0) + 1
        }
        return typeCount
    }
}

extension Array: JSONDataForm where Element == JSONType {
    var totalCount: Int {
        return self.count
    }
    
    func countType() -> [String : Int] {
        var typeCount: [String: Int] = [:]
        for value in self {
            typeCount[value.typeName] = (typeCount[value.typeName] ?? 0) + 1
        }
        return typeCount
    }
}
