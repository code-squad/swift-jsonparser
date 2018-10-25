//
//  JSONArray.swift
//  JSONParser
//
//  Created by 윤지영 on 25/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONArray: JSONDataForm {
    private let jsonArray: [JSONValue]
    
    init(jsonArray: [JSONValue]) {
        self.jsonArray = jsonArray
    }
    
    var typeName: typeName {
        return .array
    }
    
    var totalCount: Int {
        return jsonArray.count
    }
    
    func countType() -> [String : Int] {
        return TypeInspector.countType(of: jsonArray)
    }
}

