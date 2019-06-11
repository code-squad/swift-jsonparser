//
//  JSONValueType.swift
//  JSONParser
//
//  Created by CHOMINJI on 19/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JSONValueType {
   static var typeDescription: String { get }
}

protocol TypeCountable {
    var totalCount: Int { get }
    var types: [JSONValueType.Type] { get }
    var typeDescription: String { get }
}

extension TypeCountable {
    var countOfString: Int {
        return types.countType(of: String.self)
    }
}

typealias JSONContainerType = JSONValueType & TypeCountable

extension String: JSONValueType {
    static var typeDescription: String {
        return "문자열"
    }
}

typealias Number = Int
extension Number: JSONValueType {
    static var typeDescription: String {
        return "숫자"
    }
}

extension Bool: JSONValueType {
    static var typeDescription: String {
        return "부울"
    }
}

typealias Object = [String: JSONValueType]
extension Object: JSONContainerType {
    static var typeDescription: String {
        return "객체"
    }
    
    var typeDescription: String {
        return Object.typeDescription
    }
    
    var totalCount: Int {
        return self.count
    }
    
    var types: [JSONValueType.Type] {
        return self.values.map { type(of: $0) }
    }
}

typealias JSONArray = [JSONValueType]
extension JSONArray: JSONContainerType {
    static var typeDescription: String {
        return "배열"
    }
    
    var typeDescription: String {
        return JSONArray.typeDescription
    }
    
    var totalCount: Int {
        return self.count
    }
    
    var types: [JSONValueType.Type] {
        return self.map { type(of: $0) }
    }
}
