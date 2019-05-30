//
//  ErrorCode.swift
//  JSONParser
//
//  Created by 이진영 on 28/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum TypeError: Error {
    case unsupportedType
    
    var description: String {
        switch self {
        case .unsupportedType:
            return "지원하지 않는 규격"
        }
    }
}

enum ParseError: Error {
    case invalidValue
    case noData
    
    var description: String {
        switch self {
        case .invalidValue:
            return "포함될 수 없는 데이터"
        case .noData:
            return "데이터가 없음"
        }
    }
}
