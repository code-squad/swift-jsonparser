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
        static let invalidForm = "지원하지 않는 형식을 포함하고 있습니다."

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
        let typeCount = jsonDataForm.countType()
        let countNameAdded = typeCount.map { (key, value) in "\(key) \(value)\(Message.countResult.countUnit)" }
        return countNameAdded.joined(separator: "\(Message.countResult.comma) ")
    }

    static func showTypeCount(of jsonDataForm: JSONDataForm) {
        let totalCount = jsonDataForm.totalCount
        let typeName = jsonDataForm.typeName
        let typeCount = addTypeName(to: jsonDataForm)
        print(Message.countResult.makeSentence(with: totalCount, typeName, and: typeCount))
    }
    
    static func showJSONSerialization(of jsonDataForm: JSONDataForm) {
        print(jsonDataForm.prettyPrinted)
    }

    static func notifyIssue() {
        print(Message.invalidForm)
    }
}
