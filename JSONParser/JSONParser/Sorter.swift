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
            case "String" :
                swiftArr.insertIntoStrings(data.removeDoubleQuotationMarks())
            case "Number" :
                swiftArr.insertIntoNumbers(Double(data) ?? 0)
            case "Bool" :
                swiftArr.insertIntoBools(<#T##bool: Bool##Bool#>)
            default:
                <#code#>
            }
        }
        return swiftArr
    }
}
