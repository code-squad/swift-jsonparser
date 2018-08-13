//
//  JsonError.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 11..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

enum JsonError : Error {
    case unSupportedArrayPattern
    case unSupportedObjectPattern
    
    func description() -> String {
        switch self {
        case .unSupportedArrayPattern:
            return "지원하지 않는 배열 형식을 포함하고 있습니다."
        case .unSupportedObjectPattern:
            return "지원하지 않는 객체 형식을 포함하고 있습니다."
        }
    }
}
