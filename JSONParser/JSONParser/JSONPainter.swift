//
//  JSONPainter.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONPainter {
    private let jsonData: JSONData
    private(set) var jsonPainting: String = ""
    private var depth: Int = 0

    init(jsonData: JSONData) {
        self.jsonData = jsonData
    }

    mutating func paintJSON() {
        if jsonData.count == 1 {
            if let jsonObject = jsonData[0] as? JSONObject {
                paintObjectType(jsonObject: jsonObject, depth: depth)
                return
            }
        }
        paintArrayType()
    }

    mutating func paintObjectType(jsonObject: JSONObject, depth: Int) {
        jsonPainting += "{\n"
        jsonPainting += jsonObject.map { key, value in
            var valueString: String = ""
            if value is String {
                valueString = "\"" + String(describing: value) + "\""
            } else {
                valueString = String(describing: value)
            }
            return String(repeating: "\t", count: depth+1) + "\"\(key)\" : \(valueString)" + ",\n"
        }.joined(separator: "")
        jsonPainting.removeLast(2)
        jsonPainting += "\n" + String(repeating: "\t", count: depth) + "}"
    }

    mutating func paintArrayType() {
        jsonPainting += "["
        for element in jsonData {
            if let jsonObject = element as? JSONObject {
                depth += 1
                paintObjectType(jsonObject: jsonObject, depth: depth)
                jsonPainting += ",\n"
            } else {
                jsonPainting += String(repeating: "\t", count: depth) + String(describing: element) + ", "
            }
        }
        jsonPainting.removeLast(2)
        if depth > 0 {
            jsonPainting += "\n"
        }
        jsonPainting += "]"
    }

}
