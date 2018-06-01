//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by Yoda Codd on 2018. 5. 31..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    // 문자열 체크용 정규식
    let regexString = "^\".*\"$"
    // 숫자형 체크용 정규식
    let regexInt = "^[0-9]*$"
    // 참거짓 체크용 정규식
    let regexBool = "^[true]\\|[false]$"
    // 객체 체크용 정규식
    let regexObject = "^\\{.*\\}$"
    
    /// 문자열과 정규식을 받아서 정규식화 된 문자열 배열을 리턴한다
    func extractRegexed(regexTry : String, originLetter: String) -> [String]? {
        let regexForm = try! NSRegularExpression(pattern: regexTry, options: [])
        let result =  regexForm.matches(in:originLetter,range: NSRange(originLetter.startIndex..., in: originLetter))
        return result.map { String(originLetter[Range($0.range, in: originLetter)!]) }
    }
    
    
}
