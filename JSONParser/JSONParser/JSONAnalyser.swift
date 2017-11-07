//
//  JSONAnalyser.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONAnalyser {
    func getJSONData(items: Array<String>) -> JSONData {
        var typedArray : JSONData = []
        for item in items {
            typedArray.append(setEachType(item: item) ?? "")
        }
        return typedArray
    }
    
    private func setEachType(item: String) -> Any? {
        if item.contains("\"") {
            return item as String
        } else if let item = Int(item) {
            return item as Int
        } else if let item = Bool(item) {
            return item as Bool
        }
        return nil
    }
}
