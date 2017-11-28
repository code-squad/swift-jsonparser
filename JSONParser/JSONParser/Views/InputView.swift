//
//  InputView.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 17..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    enum Errors: String, Error {
        case emptyValue = "입력 값이 없습니다."
    }
    
    static func readValue() throws -> JSONDataCountable {
        print("분석할 JSON 데이터를 입력하세요.", terminator: "\n")
        
        guard let readValue = readLine() else {
            throw InputView.Errors.emptyValue
        }
        
        return try JSONParser.analyzeJSONData(in: readValue)
    }
}
