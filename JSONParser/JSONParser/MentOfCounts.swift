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
        var countOfType = ["문자열": 0, "숫자": 0, "부울": 0, "객체": 0]
        var prints: [String] = []
        
        for jsonDatum in jsonData {
            switch jsonDatum {
            case is TypeString: countOfType["문자열"] = countOfType["문자열"]! + 1
            case is TypeInt: countOfType["숫자"] = countOfType["숫자"]! + 1
            case is TypeBool: countOfType["부울"] = countOfType["부울"]! + 1
            case is TypeDictionary: countOfType["객체"] = countOfType["객체"]! + 1
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
