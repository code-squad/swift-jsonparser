//
//  ErrorControl.swift
//  JSONParser
//
//  Created by JieunKim on 29/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum JSONError: Error {
    case wrongValue
    case emptyBuffer
    case notArray
    case unexpectedSeperator
    case TokensError
    
    var localizedDescription: String {
        switch self {
        case .wrongValue:
            return "입력값이 유효하지 않습니다."
        case .emptyBuffer:
            return "buffer가 비었습니다."
        case .notArray:
            return "Array가 아닙니다."
        case .unexpectedSeperator:
            return "예상치 못한 ,가 나왔습니다."
        case .TokensError:
            return "다음 token 값이 없습니다."
        }
    }
}
