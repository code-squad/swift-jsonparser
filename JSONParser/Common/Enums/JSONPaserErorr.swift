////
////  JSONPaserErorr.swift
////  JSONParser
////
////  Created by Jung seoung Yeo on 2018. 4. 20..
////  Copyright © 2018년 JK. All rights reserved.
////

enum JsonError: Error {
    case isNil
    case isVilidLex
    case isStartToken
    case isTokenFirst
    case isToken
    case isNumberMatching
    case isStringMatching
    case isBooleanMatching
    case isConvertNumber
    case isConvertBoolean
    case isCommaNext
    case isValue
    case isNextToken
    case isOpenToken
    case isClose
    
    var description: String {
        switch self {
            case .isNil:
                return "값이 존재 하지 않습니다. 확인 해주세요."
            case .isVilidLex:
                return "lex의 값이 없습니다. 확인 해주세요"
            case .isStartToken:
                return "Token의 시작 값은 [, { 로 시작해야합니다."
            case .isTokenFirst:
                return "Token이 첫 글자가 없습니다."
            case .isToken:
                return "Token 값이 유효하지 않습니다."
            case .isNumberMatching:
                return "Token 값이 number가 아닙니다."
            case .isStringMatching:
                return "Token 값이 String이 아닙니다."
            case .isBooleanMatching:
                return "Token 값이 Boolean이 아닙니다."
            case .isConvertNumber:
                return "Token 값이 Number로 변환 할 수 없습니다."
            case .isConvertBoolean:
                return "Token 값이 Boolean으로 변환 할 수 없습니다."
            case .isCommaNext:
                return "콤마(,) 뒤의 값이 존재 해야 합니다."
            case .isValue:
                return "object의 value 값이 될 수 없습니다."
            case .isNextToken:
                return "nextToken 값이 없습니다."
            case .isOpenToken:
                return "대괄호([) 또는 중괄호({)가 없습니다."
            case .isClose:
                return "대괄호 또는 중괄호가 제대로 닫히지 않았습니다."
        }
    }
}
