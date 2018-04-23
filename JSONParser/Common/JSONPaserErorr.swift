//
//  JSONPaserErorr.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 4. 20..
//  Copyright © 2018년 JK. All rights reserved.
//

enum JSONPaserErorr: String, Error {
    case isNil = "값이 없습니다."
    case isJsonLexer = "JSON Lexer가 될 수 없습니다."
    case isJsonPaser = "JSON Parser가 될 수 없습니다."
    case notFirst = "parser : json값으로 저장할 수 없는 값 입ㄴ디ㅏ."
    case isArray = "parser : 배열을 생성 할 수 없습니다."
    case isStartBracketCapsule = "parser : 대괄호 형식이 아닙니다."
    case isNumber = "숫자로 변환이 안됩니다."
    case isBoolean = "부울 변환이 안됩니다."
    case isEmpty = "콤마 뒤에 값이 존재 하지 않습니다."
    case isRegex = "규격이 맞지 않습니다."

}
