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
        for _ in self.jsonArray {
            typeCount["객체"] = (typeCount["객체"] ?? 0) + 1
        }
        return typeCount
    }
    
}
