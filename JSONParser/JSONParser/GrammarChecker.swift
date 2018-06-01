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
    static let regexString = "^\".*\"$"
    // 숫자형 체크용 정규식
    static let regexInt = "^[0-9]*$"
    // 참거짓 체크용 정규식
    static let regexBool = "^true|false$"
    // 객체의 키와 밸류 정규식
    static let regexObjectValue = "\".+?\" : (true|false|\".+?\"|[0-9]*)"
    // 객체 체크용 정규식. 키와 벨류 사이에 , 를 추가
    static let regexObject = "^\\{ "+regexObjectValue+"(, "+regexObjectValue+")* \\}$"
    
    /// 문자열과 정규식을 받아서 정규식화 된 문자열 배열을 리턴한다
    func extractRegexed(regexTry : String, originLetter: String) -> [String]? {
        let regexForm = try! NSRegularExpression(pattern: regexTry, options: [])
        let result =  regexForm.matches(in:originLetter,range: NSRange(originLetter.startIndex..., in: originLetter))
        return result.map { String(originLetter[Range($0.range, in: originLetter)!]) }
    }
    
    /// 입력받은 문자열이 "문자열" 형태인지 체크
    func checkStringType(letter: String) -> Bool {
        // 입력받은 문자열을 문자열 정규식에 통과시킨다
        let regexedLetter = extractRegexed(regexTry: GrammarChecker.regexString, originLetter: letter)
        // 제대로 된 문자열이라면 입력값과 첫번째 정규식 항목과 같아야 한다
        return regexedLetter!.count > 0 && regexedLetter![0] == letter
    }
    
    /// 입력받은 문자열이 인트 형태인지 체크
    func checkIntType(letter: String) -> Bool {
        // 입력받은 문자열을 문자열 정규식에 통과시킨다
        let regexedLetter = extractRegexed(regexTry: GrammarChecker.regexInt, originLetter: letter)
        // 제대로 된 문자열이라면 입력값과 첫번째 정규식 항목과 같아야 한다
        return regexedLetter!.count > 0 && regexedLetter![0] == letter
    }
    
    /// 입력받은 문자열이 참거짓 형태인지 체크
    func checkBoolType(letter: String) -> Bool {
        // 입력받은 문자열을 문자열 정규식에 통과시킨다
        let regexedLetter = extractRegexed(regexTry: GrammarChecker.regexBool, originLetter: letter)
        // 제대로 된 문자열이라면 입력값과 첫번째 정규식 항목과 같아야 한다
        return regexedLetter!.count > 0 && regexedLetter![0] == letter
    }
    
    /// 입력받은 문자열이 "문자열" 형태인지 체크
    func checkObjectType(letter: String) -> Bool {
        // 입력받은 문자열을 문자열 정규식에 통과시킨다
        let regexedLetter = extractRegexed(regexTry: GrammarChecker.regexObject, originLetter: letter)
        // 제대로 된 문자열이라면 입력값과 첫번째 정규식 항목과 같아야 한다
        return regexedLetter!.count > 0 && regexedLetter![0] == letter
    }
    
}
