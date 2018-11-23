//
//  File.swift
//  JSONParser
//
//  Created by 김장수 on 12/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

enum JSONType {
    case int(Int)
    case bool(Bool)
    case string(String)
    case array(ArrayJSONData)
    case object(ObjectJSONData)
    
    var name: String {
        switch self {
        case .int:      return "숫자"
        case .bool:     return "부울"
        case .string:   return "문자열"
        case .array:    return "배열"
        case .object:   return "객체"
        }
    }
}

struct ArrayJSONData: JSONFormat {
    private let elements: [JSONType]
    
    init(elements: [JSONType]) {
        self.elements = elements
    }
    
    func typeName() -> String {
        return "배열"
    }
    
    func countsEachData() -> (int: Int, bool: Int, string: Int, array: Int, object: Int, total: Int) {
        var int = Int(), bool = Int(), string = Int(), array = Int(), object = Int()
        
        elements.forEach {
            if $0.name == "숫자" { int += 1 }
            if $0.name == "부울" { bool += 1 }
            if $0.name == "문자열" { string += 1 }
            if $0.name == "배열" { array += 1 }
            if $0.name == "객체" { object += 1 }
        }
        
        return (int: int, bool: bool, string: string, array: array, object: object, total: self.elements.count)
    }
}

struct ObjectJSONData: JSONFormat {
    private let elements: [String: JSONType]
    
    init(elements: [String: JSONType]) {
        self.elements = elements
    }
    
    func typeName() -> String {
        return "객체"
    }
    
    func countsEachData() -> (int: Int, bool: Int, string: Int, array: Int, object: Int, total: Int) {
        var int = Int(), bool = Int(), string = Int(), array = Int(), object = Int()
        
        elements.values.forEach {
            if $0.name == "숫자" { int += 1 }
            if $0.name == "부울" { bool += 1 }
            if $0.name == "문자열" { string += 1 }
            if $0.name == "배열" { array += 1 }
            if $0.name == "객체" { object += 1 }
        }
        
        return (int: int, bool: bool, string: string, array: array, object: object, total: self.elements.count)
    }
}
