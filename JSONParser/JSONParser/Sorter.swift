//
//  Sorter.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct Sorter {
    static func sortByTypeIntoArray(_ inputData:[String]) -> SwiftArray {
        var swiftArr = SwiftArray()
        for data in inputData {
            switch data.isWhatForm() {
            case "string" :
                swiftArr.insertIntoStrings(data.removeDoubleQuotationMarks())
            case "number" :
                swiftArr.insertIntoNumbers(Double(data) ?? 0)
            case "bool" :
                swiftArr.insertIntoBools(data.isTrue())
            default : continue
            }
        }
        return swiftArr
    }
}
