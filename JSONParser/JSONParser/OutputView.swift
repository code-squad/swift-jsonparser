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
        static let invalidForm = "지원하는 규격이 아닙니다."
        
        struct countResult {
            static let noCount = 0
            static let countUnit = "개"
            static let comma = ","
            static func makeSentence(with totalCount: Int, and typeCount: String) -> String {
                return "총 \(totalCount)개의 데이터 중에 \(typeCount)가 포함되어 있습니다."
            }
        }
    }
    
    private static func addTypeName(to jsonArray: [Any?]) -> String {
        var typeNames: [String?] = [typeName.string.rawValue, typeName.int.rawValue, typeName.bool.rawValue]
        let typeCount = TypeInspector.countType(of: jsonArray)
        for index in 0..<typeNames.count {
            let key = typeNames[index] ?? typeName.none.rawValue
            guard let count = typeCount[key] else {
                typeNames[index] = nil
                continue
            }
            typeNames[index]?.append(" \(count)\(Message.countResult.countUnit)")
        }
        return typeNames.compactMap({$0}).joined(separator: "\(Message.countResult.comma) ")
    }
    
    static func showTypeCountOf(JSON jsonArray: [Any?]) {
        let totalCount = jsonArray.count
        let typeCount = addTypeName(to: jsonArray)
        print(Message.countResult.makeSentence(with: totalCount, and: typeCount))
    }
    
    static func notifyIssue() {
        print(Message.invalidForm)
    }
}
