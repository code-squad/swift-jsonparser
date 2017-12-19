//
//  JsonSyntaxChecker.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 14..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

// Json 문법검사 구조체
struct SyntaxChecker {
    enum ErrorMessage: String, Error {
        case ofInvalidInput = "입력값이 유효하지 않습니다."
    }
    
    // 문법을 검사하여 통과시 배열로 반환
    static func makeValidString (values: String) throws -> String {
        guard checkIsValidJsonArrayPattern(values) || checkIsValidJsonObjectPattern(values) else { throw ErrorMessage.ofInvalidInput }
        return findJsonString(from: values)
    }
    
    // JsonArray패턴에 맞는지 검사
    private static func checkIsValidJsonArrayPattern (_ stringValue: String) -> Bool{
        let regex = try! NSRegularExpression(pattern: JSONPattern.ofArray)
        let results = regex.matches(in: stringValue, range: NSRange(location: 0, length: stringValue.count))
        return !results.isEmpty
    }
    
    // JsonObject패턴에 맞는지 검사
    private static func checkIsValidJsonObjectPattern (_ stringValue: String) -> Bool{
        let regex = try! NSRegularExpression(pattern: JSONPattern.ofObject)
        let results = regex.matches(in: stringValue, range: NSRange(location: 0, length: stringValue.count))
        return !results.isEmpty
    }
    
    // 문자열에서 공백만 제거
    private static func findJsonString (from validString: String) -> String{
        let splitted = validString.filter { $0 != " " }
        return splitted
    }
    
}
