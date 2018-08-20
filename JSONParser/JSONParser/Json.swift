//
//  Json.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 6..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

protocol Jsonable {
    func countData() -> (Int,Int,Int,Int,Int)
    func generateData() -> String
}

enum JsonType:Equatable {
    case string(String)
    case int(Int)
    case bool(Bool)
    case object([String:JsonType])
    case array([JsonType])
    
    func description(intent: Int) -> String {
        switch self {
        case .string(let element):
            return element
        case .int(let element):
            return String(element)
        case .bool(let element):
            return String(element)
        case .object(let element):
            let jsonObject = JsonObject.init()
            return jsonObject.makeObject(intent: intent + 1, elements: element)
        case .array(let element):
            let jsonArray = JsonArray.init()
            return jsonArray.makeArray(intent: intent + 1, elements: element)
        }
    }
}
