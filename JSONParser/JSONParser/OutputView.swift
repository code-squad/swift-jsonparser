//
//  OutputView.swift
//  JSONParser
//
//  Created by 윤지영 on 18/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct OutputView {
    static private let outputFileDirPath = "/Users/yxxjy/DevNote/swift-jsonparser/"
    static private let defaultOutputFile = "output.json"
    
    struct Message {
        enum Error: String {
            case noInputFile = "파싱할 JSON 파일이 미지정되었습니다."
            case invalidForm = "지원하지 않는 형식을 포함하고 있습니다."
            case unableToSave = "정상적으로 저장되지 않았습니다."
        }

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
    
    static func showJSONPrettyPrinted(of jsonDataForm: JSONDataForm) {
        print(jsonDataForm.prettyPrinted)
    }
    
    static func writeJSONPrettyPrinted(of jsonDataForm: JSONDataForm) {
        let contents = jsonDataForm.prettyPrinted
        let file = InputView.readArgument(atIndex: .outputFile) ?? defaultOutputFile
        let fileURL = URL(fileURLWithPath: "\(outputFileDirPath)\(file)")
        do {
            try contents.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            notifyIssue(of: .unableToSave)
        }
    }

    static func notifyIssue(of error: Message.Error) {
        print(error.rawValue)
    }
}
