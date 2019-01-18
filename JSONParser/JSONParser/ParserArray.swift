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
        //https://developer.apple.com/documentation/swift/array/2297359-contains
        if self.contains(where: { element in
            return element is [String: JSONType]}) {
            
            let dataArrayObject = self.map{ "\($0 is [String: JSONType] ? ($0 as! [String: JSONType]).manyTypeData : $0.typeData)" }.joined(separator: ",\n\t")
            
            return "[\(dataArrayObject)\n]"
        }
        
        let array = self.map { "\($0.typeData)" }.joined(separator: ", ")
        print(array)
        
        return "[\(array)]"
    }
    
}
