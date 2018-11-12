//
//  Sorter.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct Sorter {
    static func sortByType(_ inputData:[String]) -> [Any] {
        var jsonData = [Any]()
        for data in inputData {
            switch data.isWhatForm() {
            case "string":
                jsonData.append(data.removeDoubleQuotationMarks())
            case "number":
                jsonData.append(Double(data) ?? 0)
            case "bool":
                jsonData.append(data.isTrue())
            default:
                continue
            }
        }
        return jsonData
    }
}
