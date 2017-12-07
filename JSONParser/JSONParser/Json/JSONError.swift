//
//  JSONError.swift
//  JSONParser
//
//  Created by yuaming on 2017. 12. 7..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

enum JSONError: String, Error {
    case unsupportedFormat = "지원하지 않는 형식입니다."
    case emptyValue = "입력 값이 없습니다."
    case notDataConversation = "데이터 변환 도중 오류가 발생하였습니다."
}
