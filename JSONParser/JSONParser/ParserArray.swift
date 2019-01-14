//
//  ParserArray.swift
//  JSONParser
//
//  Created by Elena on 02/01/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

import Foundation

extension Array: JSONDataForm where Element == JSONType {
    var totalCount: Int {
        return self.count
    }
    
    func countValue() -> [String : Int] {
        var typeCount: [String: Int] = [:]
        for value in self {
            typeCount[value.typeName] = (typeCount[value.typeName] ?? 0) + 1
        }
        return typeCount
    }
}

extension Array: JSONType where Element == JSONType {
    var typeName: String {
        return "배열"
    }
    var typeData: String {
        return "\(self)"
    }
}
