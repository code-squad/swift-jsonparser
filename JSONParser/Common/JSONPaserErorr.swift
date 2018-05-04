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
    case noStartToken = "시작 Token 값은 {, [ 만 가능합니다."
    case isJsonPaser = "JSON Parser가 될 수 없습니다."
    case notFirst = "parser : json값으로 저장할 수 없는 값 입니다."
    case noArrayMake = "parser : 배열을 만들 수 없습니다."
    case noOjbectMake = "parser : 오브젝트를 만들 수 없습니다."
    case isCapsule = "대괄호 및 중괄호가 닫히지 않았습니다."
    case isNumber = "숫자로 변환이 안됩니다."
    case isBoolean = "부울 변환이 안됩니다."
    case isObject = "오브젝트가 아닙니다."
    case isNextToken = " , : 뒤에는 값이 존재해야합니다."
    case isRegex = "규격이 맞지 않습니다."
    
}
