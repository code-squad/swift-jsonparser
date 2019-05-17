//
//  JSONParserError.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JSONParserError: Error {
    var message: String { get }
}

enum InputError: String, JSONParserError {
    case invalidFormat = "잘못된 입력입니다."
    var message: String {
        return self.rawValue
    }
}

enum TokenizerError: String, JSONParserError {
    case impossibleToTokenize = "입력 문자열을 나눌 수 없습니다."
    var message: String {
        return self.rawValue
    }
}

enum ParserError: String, JSONParserError {
    case invalidFormatToParse = "파싱할 수 없는 형식입니다."
    case impossibleToParse = "의미있는 type으로 변환할 수 없습니다."
    var message: String {
        return self.rawValue
    }
}

enum ValueFactoryError: String, JSONParserError {
    case impossibleToCreateJSONValue = "JSON value를 생성할 수 없습니다."
    var message: String {
        return self.rawValue
    }
}

