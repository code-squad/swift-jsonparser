//
//  JSONParserError.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JSONError: Error {
    var message: String { get }
}

enum InputError: String, JSONError {
    case invalidInputFormat = "잘못된 입력입니다."
    
    var message: String {
        return self.rawValue
    }
}

enum TokenizerError: String, JSONError {
    case impossibleToTokenize = "입력 문자열을 나눌 수 없습니다."
    
    var message: String {
        return self.rawValue
    }
}

enum TokenReaderError: String, JSONError {
    case hasNoNextToken = "더 이상 읽을 token이 없습니다."
    
    var message: String {
        return self.rawValue
    }
}

enum ParserError : String, JSONError {
    case invalidSymbolToParse = "JSON Data가 허용하지 않는 문자가 포함되어 있습니다."
    case invalidFirstSymbolOfJSONData = "JSON 데이터가 { 혹은 [로 시작하지 않습니다."
    case impossibleToParse = "JSON Value로 파싱할 수 없습니다."
    
    var message: String {
        return self.rawValue
    }
}

enum JSONValueFactoryError: String, JSONError {
    case impossibleToConvertIntoBool = "주어진 token을 Bool로 변환할 수 없습니다."
    case impossibleToconvertIntoNumber = "주어진 token을 숫자로 변환할 수 없습니다."
    
    var message: String {
    return self.rawValue
    }
}

enum OutputError: String, JSONError {
    case impossibleToCountElement = "파싱된 json 값의 요소를 셀 수 없습니다."
    case impossibleToPrintDescription = "json value의 정보를 출력할 수 없습니다."
    
    var message: String {
        return self.rawValue
    }
}

