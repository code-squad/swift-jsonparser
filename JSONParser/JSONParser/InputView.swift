//
//  InputView.swift
//  JSONParser
//
//  Created by BLU on 2019. 5. 28..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

struct InputView {
    
    enum Error: Swift.Error {
        case isEmptyInput
        
        var localizedDescription: String {
            switch self {
            case .isEmptyInput:
                return "입력이 정의되지 않았습니다."
            }
        }
    }
    
    enum Question: String {
        case enterJSONData = "분석할 JSON 데이터를 입력하세요."
    }
    
    private static func readText(ask question: Question) throws -> String {
        print(question.rawValue)
        guard let input = readLine(), !input.isEmpty else {
            throw InputView.Error.isEmptyInput
        }
        return input
    }
    
    static func readJSONData() throws -> String {
        return try readText(ask: .enterJSONData)
    }
}
