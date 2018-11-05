//
//  JSONParser.swift
//  JSONParser
//
//  Created by 윤동민 on 02/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    // JSON -> Swift 타입으로 추출해 냄
    func extractJSONtoSwift(jsonData : [String]) -> [Any] {
        let checkType = CheckType()
        var jsonToSwift : [Any] = []
        for data in jsonData {
            switch checkType.supportingType(data) {
            case .stringType :
                jsonToSwift.append(data)
            case .booleanType :
                jsonToSwift.append(data)
            case .numberType :
                jsonToSwift.append(data)
            default :
                return []
            }
        }
        return jsonToSwift
    }
    
    // String으로 데이터를 추출
    private func extractString(_ data : String) -> String {
        return data
    }
    
    // Bool으로 데이터를 추출
    private func extractBoolean(_ data : String) -> Bool {
        guard data == "true" else { return false }
        return true
    }
    
    // Double으로 데이터를 추출
    private func extractNumber(_ data : String) -> Double {
        guard let convertedNumber = Double(data) else { return 0 }
        return convertedNumber
    }
}
