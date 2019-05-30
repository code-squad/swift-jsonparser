//
//  OutputView.swift
//  JSONParser
//
//  Created by CHOMINJI on 22/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    static func printDescription(of input: [JSONValueType]) {
        let description = printTypesCount(of: input)
        print(description)
    }
    
    static private func printTypesCount(of arrayValue: [JSONValueType]) -> String {
        let totalCount = arrayValue.count
        
        let counts = TypeCounter.count(of: arrayValue)
        let countOfString = counts.string
        let countOfNumber = counts.number
        let countOfBool = counts.bool
        
        var description = "총 \(totalCount)개의 데이터 중에 "
        
        if countOfString > 0 {
            description += "\(String.typeDescription) \(countOfString)개 "
        }
        
        if countOfNumber > 0 {
            description += "\(Number.typeDescription) \(countOfNumber)개 "
        }
        
        if countOfBool > 0 {
            description += "\(Bool.typeDescription) \(countOfBool)개 "
        }
        
        return description
    }
}
