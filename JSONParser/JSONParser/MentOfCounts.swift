//
//  countOfType.swift
//  JSONParser
//
//  Created by jang gukjin on 18/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct MentOfCounts {
    static func makeMent(jsonData: [Json]) -> String {
        var countOfType = [String().ment: 0, Int().ment: 0, Bool().ment: 0, Dictionary<String, Json>().ment: 0, Array<Json>().ment: 0]
        var prints: [String] = []
        
        for jsonDatum in jsonData {
            switch jsonDatum {
            case is String: countOfType[String().ment] = countOfType[String().ment]! + 1
            case is Int: countOfType[Int().ment] = countOfType[Int().ment]! + 1
            case is Bool: countOfType[Bool().ment] = countOfType[Bool().ment]! + 1
            case is Array<Json>: countOfType[Array<Json>().ment] = countOfType[Array<Json>().ment]! + 1
            case is Dictionary<String, Json>: countOfType[Dictionary<String, Json>().ment] = countOfType[Dictionary<String, Json>().ment]! + 1
            default: break
            }
        }
        
        for (key, value) in countOfType {
            let ment = MentOfCounts().distinctAndMakeMent(key: key, value: value)
            prints.append(ment)
        }

        let setPrint = prints.filter { $0 != ""}.joined(separator: ", ")
        return setPrint
    }
    
    private func distinctAndMakeMent(key: String, value: Int) -> String{
        if value > 0 {
            let ment = "\(key) \(value)개"
            return ment
        }
        else {
            return ""
        }
    }
}
