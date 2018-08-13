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
    
    func isError() -> Bool {
        switch self {
        case .unSupportedArrayPattern:
            print("지원하지 않는 배열 형식을 포함하고 있습니다.")
            return true
        case .unSupportedObjectPattern:
            print("지원하지 않는 객체 형식을 포함하고 있습니다.")
            return true
        }
    }
}
