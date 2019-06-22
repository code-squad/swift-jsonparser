//
//  StringInterpolation.swift
//  JSONParser
//
//  Created by Daheen Lee on 21/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

extension String.StringInterpolation {
    mutating func appendInterpolation(typeCountDescription value: JSONValue & TypeCountable) {
        let prefixDescription = "총 \(value.elementCount)개의 \(value.typeDescription) 데이터 중에 "
        let suffixDescription = "가 포함되어 있습니다."
        var elementDescription = String()
        let seperator = ", "
        var prefix = String()
        let totalTypeCountPair = TypeCounter.getTotalTypeCount(of: value)
        for (typeDescription, count) in totalTypeCountPair {
            elementDescription += prefix
            elementDescription += "\(typeDescription) \(count)개"
            prefix = seperator
        }
        appendInterpolation("\(prefixDescription)\(elementDescription)\(suffixDescription)")
    }
    

}
