//
//  Error.swift
//  JSONParser
//
//  Created by 이동건 on 14/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

enum JSONParserError: Error, CustomStringConvertible {
    case invalidInput
    case invalidFormat
    case unexpected
    
    var description: String {
        switch self {
        case .invalidFormat:
            return "지원하지 않는 포맷이 포함되어 있습니다."
        case .invalidInput:
            return "입력 값이 유효하지 않습니다."
        case .unexpected:
            return "예상치 못한 오류가 발생하였습니다."
        }
    }
}
