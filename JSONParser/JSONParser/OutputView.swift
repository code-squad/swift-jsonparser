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
            static func makeSentence(with totalCount: Int, _ dataForm: String, and typeCount: String) -> String {
                return "총 \(totalCount)개의 \(dataForm) 데이터 중에 \(typeCount)가 포함되어 있습니다."
            }
        }
    }
    
    private static func addTypeName(to jsonDataForm: JSONDataForm) -> String {
        var typeNames: [String?] = ["문자열", "숫자", "부울", "객체"]
        let typeCount = jsonDataForm.countType()
        for index in 0..<typeNames.count {
            let key = typeNames[index] ?? ""
            guard let count = typeCount[key] else {
                typeNames[index] = nil
                continue
            }
            typeNames[index]?.append(" \(count)\(Message.countResult.countUnit)")
        }
        return typeNames.compactMap({$0}).joined(separator: "\(Message.countResult.comma) ")
    }
    
    static func showTypeCount(of jsonDataForm: JSONDataForm) {
        let totalCount = jsonDataForm.totalCount
        let dataForm = jsonDataForm.typeName
        let typeCount = addTypeName(to: jsonDataForm)
        print(Message.countResult.makeSentence(with: totalCount, dataForm, and: typeCount))
    }
    
    static func notifyIssue() {
        print(Message.invalidForm)
    }
}
