//
//  JSONType.swift
//  JSONParser
//
//  Created by 윤지영 on 23/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public enum JSONValue {
    case string(String)
    case int(Int)
    case bool(Bool)
    case object([String : JSONValue])
    case array([JSONValue])
}

protocol JSONDataForm {
    var typeName: typeName { get }
    var totalCount: Int { get }
    func countType() -> [String: Int]
}

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


