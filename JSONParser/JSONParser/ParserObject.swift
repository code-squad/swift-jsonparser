//
//  ParserObject.swift
//  JSONParser
//
//  Created by Elena on 02/01/2019.
//  Copyright © 2019 JK. All rights reserved.
//
import Foundation

struct ParserObject: JSONDataForm {
    private let jsonObject: [String: JSONType]
    
    init(_ jsonObject: [String: JSONType]) {
        self.jsonObject = jsonObject
    }
    
    var typeName: String {
        return JSONType.object(self).typeName
    }
    
    var totalCount: Int {
        return jsonObject.count
    }
    
    func printType() -> [String : Int] {
        var typeCount: [String: Int] = [:]
        for value in self.jsonObject.values {
            typeCount[value.typeName] = (typeCount[value.typeName] ?? 0) + 1
        }
        return typeCount
    }
    
}
