//
//  JSONObject.swift
//  JSONParser
//
//  Created by 윤지영 on 25/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONObject: JSONDataForm {
    private let jsonObject: [String: JSONValue]
    
    init(jsonObject: [String: JSONValue]) {
        self.jsonObject = jsonObject
    }
    
    var typeName: typeName {
        return .object
    }
    
    var totalCount: Int {
        return jsonObject.count
    }
    
    func countType() -> [String : Int] {
        return TypeInspector.countType(of: Array(jsonObject.values))
    }
}
