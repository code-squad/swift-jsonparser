//
//  OutputView.swift
//  JSONParser
//
//  Created by 윤지영 on 18/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct Message {
    static let invalidForm = "지원하는 규격이 아닙니다."
    
    struct countResult {
        static let string = "문자열"
        static let int = "숫자"
        static let bool = "부울"
        static let noCount = 0
        static let countUnit = "개"
        static let comma = ","
        static func makeSentence(with totalCount: Int, and typeCount: String) -> String {
            return "총 \(totalCount)개의 데이터 중에 \(typeCount)가 포함되어 있습니다."
        }
    }
}

struct OutputView {
    private static func addTypeName(to jsonArray: [Any?]) -> String {
        var typeName: [String?] = [Message.countResult.string, Message.countResult.int, Message.countResult.bool]
        let typeCount = TypeInspector.countType(of: jsonArray)
        for index in 0..<typeName.count {
            let key = typeName[index] ?? ""
            guard let count = typeCount[key] else {
                typeName[index] = nil
                continue
            }
            typeName[index]?.append(" \(count)\(Message.countResult.countUnit)")
        }
        return typeName.compactMap({$0}).joined(separator: "\(Message.countResult.comma) ")
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
