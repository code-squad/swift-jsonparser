//
//  JSONPainter.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONPainter {
    private(set) var jsonPainting: String = ""
    private var depth: Int = 0

    mutating func paintJSON(jsonType: JSONType) {
        if let jsonObject = jsonType as? JSONObject {
            paintObjectType(jsonObject: jsonObject)
        } else {
            let jsonArray = jsonType as? JSONArray
            paintArrayType(jsonArray: jsonArray!)
        }
    }

    private mutating func paintObjectType(jsonObject: JSONObject) {
        jsonPainting += "{\n"
        jsonPainting += jsonObject.JSONObject.map { key, value in
            var valueString: String = ""
            if value is String {
                valueString = "\"" + String(describing: value) + "\""
            } else if let jsonArray = value as? JSONArray {
                valueString = String(describing: jsonArray.JSONArray)
            } else {
                valueString = String(describing: value)
            }
            return String(repeating: "\t", count: depth+1) + "\"\(key)\" : \(valueString)" + ",\n"
        }.joined(separator: "")
        jsonPainting.removeLast(2)
        jsonPainting += "\n" + String(repeating: "\t", count: depth) + "}"
    }

    private mutating func paintArrayType(jsonArray: JSONArray) {
        jsonPainting += "["
        paintInsideOfArray(jsonArray: jsonArray)
        jsonPainting.removeLast(2)
        if depth > 0 {
            jsonPainting += "\n"
        }
        jsonPainting += "]"
    }

    private mutating func paintInsideOfArray(jsonArray: JSONArray) {
        for element in jsonArray.JSONArray {
            if let jsonObject = element as? JSONObject {
                paintObjectType(jsonObject: jsonObject)
                jsonPainting += ",\n"
            } else {
                var item: Any = element
                if let tmp = element as? JSONArray {
                    depth += 1
                    jsonPainting += "\n"
                    item = tmp.JSONArray
                }
                jsonPainting += String(repeating: "\t", count: depth) + String(describing: item) + ", "
            }
        }
    }

}
