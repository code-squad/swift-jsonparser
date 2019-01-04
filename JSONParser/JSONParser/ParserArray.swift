//
//  ParserArray.swift
//  JSONParser
//
//  Created by Elena on 02/01/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct ParserArray: JSONDataForm {
    private let jsonArray: [JSONType]
    
    init(_ dataArray: [JSONType]) {
        self.jsonArray = dataArray
    }
    
    var typeName: String {
        return JSONType.array(self).typeName
    }
    
    var totalCount: Int {
        return jsonArray.count
    }
    
    func printType() -> [String : Int] {
        var typeCount: [String: Int] = [:]
        for jsonValue in self.jsonArray {
            typeCount[jsonValue.typeName] = (typeCount[jsonValue.typeName] ?? 0) + 1
        }
        return typeCount
    }
    
}
