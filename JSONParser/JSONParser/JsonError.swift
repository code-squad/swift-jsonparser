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
    case fileNotFound
    case unableToCreateFile
    case pathNotFound
    case unknown
    
    func description() -> String {
        switch self {
        case .unSupportedArrayPattern:
            return "지원하지 않는 배열 형식을 포함하고 있습니다."
        case .unSupportedObjectPattern:
            return "지원하지 않는 객체 형식을 포함하고 있습니다."
        case .fileNotFound:
            return "해당 파일을 찾을 수가 없습니다."
        case .unableToCreateFile:
            return "파일을 생성할 수 없습니다."
        case .pathNotFound:
            return "경로를 찾을 수 없습니다."
        case .unknown:
            return "알 수 없는 에러가 발생하였습니다."
        }
    }
}
