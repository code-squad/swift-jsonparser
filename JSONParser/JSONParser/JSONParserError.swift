//
//  JSONParserError.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum JSONError: String, Error {
    case invalidInputFormat = "잘못된 입력입니다."
    case impossibleToTokenize = "입력 문자열을 나눌 수 없습니다."
    case invalidFormatToParse = "파싱할 수 없는 형식입니다."
    case impossibleToParse = "의미있는 type으로 변환할 수 없습니다."
    case impossibleToCreateJSONValue = "JSON value를 생성할 수 없습니다."
    
    var message: String {
        return self.rawValue
    }
}
