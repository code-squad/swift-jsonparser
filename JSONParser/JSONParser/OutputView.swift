//
//  OutputView.swift
//  JSONParser
//
//  Created by 윤지영 on 18/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct OutputView {
    private struct Message {
        static let invalidJSON = "JSON 규격이 아닙니다."
        
        struct countResult {
            static let typeString = "문자열"
            static let typeDouble = "숫자"
            static let typeBool = "부울"
            static let noCount = 0
            static let countUnit = "개"
            static let comma = ","
            static func makeSentence(with totalCount: Int, and typeCount: String) -> String {
                return "총 \(totalCount)개의 데이터 중에 \(typeCount)가 포함되어 있습니다."
            }
        }
    }
    
    private static func countType(in stringArray: [String]) -> [Int] {
        var typeCount = [Int]()
        typeCount.append(StringInspector.countType(in: stringArray))
        typeCount.append(DoubleInspector.countType(in: stringArray))
        typeCount.append(BooleanInspector.countType(in: stringArray))
        return typeCount
    }
    
    private static func addTypeName(in stringArray: [String]) -> String {
        var typeName: [String?] = [Message.countResult.typeString, Message.countResult.typeDouble, Message.countResult.typeBool]
        let typeCount = countType(in: stringArray)
        for index in 0..<typeName.count {
            if (typeCount[index] == Message.countResult.noCount) {
                typeName[index] = nil
                continue
            }
            typeName[index]?.append(" \(typeCount[index])\(Message.countResult.countUnit)")
        }
        return typeName.compactMap({$0}).joined(separator: "\(Message.countResult.comma) ")
    }
    
    static func showTypeCountOf(JSON stringArray: [String]) {
        let totalCount = stringArray.count
        let typeCount = addTypeName(in: stringArray)
        print(Message.countResult.makeSentence(with: totalCount, and: typeCount))
    }
    
    static func notifyIssue() {
        print(Message.invalidJSON)
    }
}
