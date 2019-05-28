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
    
    func readText() throws -> String {
        guard let input = readLine(), !input.isEmpty else {
            throw Error.isEmptyInput
        }
        return input
    }
}
