//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by Yoda Codd on 2018. 5. 31..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    // 문자열 체크용 정규식용 문자열
    let regexString = "^\".*\"$"
    // 숫자형 체크용 정규식용 문자열
    let regexInt = "^[0-9]*$"
    // 참거짓 체크용 정규식용 문자열
    let regexBool = "^[true]\\|[false]$"
    // 객체 체크용 정규식용 문자열
    let regexObject = "^\\{.*\\}$"
    
    /// 정규식용 문자열을 넣어서 정규식을 만드는 함수
    func makeRegexForm(regexTry : String)->NSRegularExpression?{
        let regexForm = try! NSRegularExpression(pattern: regexTry, options: [])
        return regexForm
    }
    
    /// 문자열과 정규식을 받아서 정규식에 맞는 문자열 배열로 리턴
    func extractLettersFrom(originLetters : String, regex : NSRegularExpression) -> Array<String>{
        let originForRange = originLetters as NSString
        return regex.matches(in : originLetters, options: [], range: NSRange(location : 0 , length : originForRange.length)).map{
            originForRange.substring(with: $0.range)
        }
    }
    
    
}
