//
//  OutputView.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    static private let suffixCountDescription = "가 포함되어 있습니다."
    static private let emptyString = ""
    
    static func printJSONDescription(of value: JSONValue) throws {
        guard let typeCountableJSONValue = value as? JSONValue & TypeCountable else {
            throw OutputError.impossibleToPrintDescription
        }
        printTypeCountDescription(of: typeCountableJSONValue)
    }
    
    static private func printTypeCountDescription(of value: JSONValue & TypeCountable) {
        let prefixCountDescription = "총 \(value.elementCount)개의 \(value.typeDescription) 데이터 중에"
        var typeCountDescription = String()
        let totalTypeCountPair = TypeCounter.getTotalTypeCount(of: value)
        for (typeDescription, count) in totalTypeCountPair {
            typeCountDescription += " \(typeDescription) \(count)개,"
        }
        let range = typeCountDescription.startIndex..<typeCountDescription.index(before: typeCountDescription.endIndex)
        let middleCountDescription = typeCountDescription[range]
        return print(prefixCountDescription, middleCountDescription, suffixCountDescription, separator: emptyString)
    }
}
