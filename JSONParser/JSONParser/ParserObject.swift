//
//  ParserObject.swift
//  JSONParser
//
//  Created by Elena on 02/01/2019.
//  Copyright © 2019 JK. All rights reserved.
//
import Foundation

extension Dictionary: JSONType where Key == String, Value == JSONType {
    var typeName: String {
        return "객체"
    }
    
    var typeData: String {
        return "\(self)"
    }
}

extension Dictionary: JSONDataForm where Key == String, Value == JSONType {
    var totalCount: Int {
        return self.count
    }
    
    func countValue() -> [String : Int] {
        var typeCount: [String: Int] = [:]
        for value in self.values {
            typeCount[value.typeName] = (typeCount[value.typeName] ?? 0) + 1
        }
        return typeCount
    }
}



