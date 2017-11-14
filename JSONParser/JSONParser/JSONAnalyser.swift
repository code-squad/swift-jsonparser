//
//  JSONAnalyser.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONAnalyser {
    static func getJSONData(items: Array<String>) -> JSONData {
        var typedArray : JSONData = []
        for item in items {
            typedArray.append(setEachType(item: item) ?? "")
        }
        return typedArray
    }
    
    private static func setEachType(item: String) -> Any? {
        if item.starts(with: "{") {
            return getJSONObject(items: item.getElementsForObject())
        } else if item.starts(with: "[") {
            return getJSONData(items: item.getElementsAll())
        } else if item.starts(with: "\"") {
            return item.replacingOccurrences(of: "\"", with: "")
        } else if let item = Int(item) {
            return item as Int
        } else if let item = Bool(item) {
            return item as Bool
        }
        return nil
    }
    
    private static func getJSONObject(items: Array<String>) -> JSONObject {
        var jsonObject : JSONObject = [:]
        for item in items {
            let keyValue = item.split(separator: ":").map {$0.trimmingCharacters(in: .whitespaces)}
            let key : String = String(keyValue[0]).replacingOccurrences(of: "\"", with: "")
            let value : Any = setEachType(item: String(keyValue[1])) ?? ""
            jsonObject[key] = value
        }
        return jsonObject
    }
}
