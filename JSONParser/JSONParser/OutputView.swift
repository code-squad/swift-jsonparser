//
//  OutputView.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    static func printJSONDescription(of values: [JSONValue]) {
        let totalCount = values.count
        let typeCountDescription = getTypeCountDescription(of: values)
        let finalDescription = "총 \(totalCount)개의 데이터 중에\(typeCountDescription)가 포함되어 있습니다"
        
        print(finalDescription)
    }
    
    static private func getTypeCountDescription(of values: [JSONValue]) -> String {
        var typeCountDescription: String = ""
        let totalTypeCountPair = TypeCounter.getTotalTypeCount(of: values)
        for (typeDescription, count) in totalTypeCountPair {
            if count != 0 {
                typeCountDescription += " \(typeDescription) \(count)개,"
            }
        }
        let range = typeCountDescription.startIndex..<typeCountDescription.index(before: typeCountDescription.endIndex)
        return String(typeCountDescription[range])
    }
    
}
