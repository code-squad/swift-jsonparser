//
//  OutputView.swift
//  JSONParser
//
//  Created by Elena on 19/12/2018.
//  Copyright © 2018 elena. All rights reserved.
//

import Foundation

struct OutputView {
    struct Message {
        
        enum Error: String {
            case invalidForm = "지원하지 않는 형식을 포함하고 있습니다."
            case noInvalidSave = "저장되지 않음"
        }

        struct countResult {
            static let noCount = 0
            static let countUnit = "개"
            static let comma = ","
            
            static func parserResultData(_ totalCount: Int, _ dataForm: String, and typeCount: String) -> String {
                return "총 \(totalCount)개의 \(dataForm) 데이터 중에 \(typeCount)가 포함되어 있습니다."
            }
        }
    }
   
    private static func addTypeName(_ data: JSONDataForm) -> String {
        let typeCount = data.countValue()
        let countNameAdded = typeCount.map { (key, value) in "\(key) \(value)\(Message.countResult.countUnit)" }
        return countNameAdded.joined(separator: "\(Message.countResult.comma) ")
    }
    
    static func showResultData(_ data: JSONDataForm) {
        let totalCount = data.totalCount
        let typeName = data.typeName
        let typeCount = addTypeName(data)
        print(Message.countResult.parserResultData(totalCount, typeName, and: typeCount))
    }
    
    static func showJSONTypeData(_ data: JSONDataForm) {
        print(data.typeData)
    }
    
    static func errorResult(_ error: Message.Error) {
        print(error.rawValue)
    }
    
    static func writeShowJSONTypeData(_ jsonDataForm: JSONDataForm,_ file: String) {
        let data = jsonDataForm.typeData
        guard let fileURL = File.getURL(file) else { return }
        do {
            try data.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            errorResult(.noInvalidSave)
        }
    }
}
