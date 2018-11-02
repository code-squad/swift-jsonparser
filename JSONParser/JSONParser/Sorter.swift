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
            case .swiftString :
                swiftArr.insertIntoStrings(data.removeDoubleQuotationMarks())
            case .swiftNumber :
                swiftArr.insertIntoNumbers(Double(data) ?? 0)
            case .swiftBool :
                swiftArr.insertIntoBools(<#T##bool: Bool##Bool#>)
            case .none : continue
            }
        }
        return swiftArr
    }
}
