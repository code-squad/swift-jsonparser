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
    static let regexString = "^\\\".*\\\"$"
    // 숫자형 체크용 정규식
    static let regexInt = "^[0-9]*$"
    // 참거짓 체크용 정규식에 쓸 문자열 생성함수
    static func typeOfBool() -> String{
        // 결과 리턴용 변수
        var result = ""
        // JSON 에서 사용 가능한 참거짓 배열을 반복문에 넣는다
        for type in JSONParser.booleanType {
            // 정규식에 맞도록 타입 뒤에 | 를 붙여준다
            result.append(type+"|")
        }
        // 타입뒤가 | 로 끝나기 때문에 마지막 문자를 지워주고 리턴한다
        result.removeLast()
        return result
    }
    // 참거짓 체크용 정규식
    static let regexBool = typeOfBool()
    // 객체의 키와 밸류 정규식
    static let regexObjectValue = "\\\".+?\\\" : (true|false|\\\".+?\\\"|[0-9]*)"
    // 객체 체크용 정규식. 키와 벨류 사이에 , 를 추가
    static let regexObject = "^\\{ "+regexObjectValue+"(, "+regexObjectValue+")* \\}$"
    
    /// 문자열과 정규식을 받아서 정규식화 된 문자열 배열을 리턴한다
    static func extractRegexed(regexTry : String, originLetter: String) -> [String]? {
        let regexForm = try! NSRegularExpression(pattern: regexTry, options: [])
        let result =  regexForm.matches(in:originLetter,range: NSRange(originLetter.startIndex..., in: originLetter))
        return result.map { String(originLetter[Range($0.range, in: originLetter)!]) }
    }
    
    /// 입력받은 문자열이 "문자열" 형태인지 체크
    static func checkStringType(letter: String) -> Bool {
        // 입력받은 문자열을 문자열 정규식에 통과시킨다
        let regexedLetter = extractRegexed(regexTry: GrammarChecker.regexString, originLetter: letter)
        // 제대로 된 문자열이라면 입력값과 첫번째 정규식 항목과 같아야 한다
        return regexedLetter!.count > 0 && regexedLetter![0] == letter
    }
    
    /// 입력받은 문자열이 인트 형태인지 체크
    static func checkIntType(letter: String) -> Bool {
        // 입력받은 문자열을 문자열 정규식에 통과시킨다
        let regexedLetter = extractRegexed(regexTry: GrammarChecker.regexInt, originLetter: letter)
        // 제대로 된 문자열이라면 입력값과 첫번째 정규식 항목과 같아야 한다
        return regexedLetter!.count > 0 && regexedLetter![0] == letter
    }
    
    /// 입력받은 문자열이 참거짓 형태인지 체크
    static func checkBoolType(letter: String) -> Bool {
        // 입력받은 문자열을 문자열 정규식에 통과시킨다
        let regexedLetter = extractRegexed(regexTry: GrammarChecker.regexBool, originLetter: letter)
        // 제대로 된 문자열이라면 입력값과 첫번째 정규식 항목과 같아야 한다
        return regexedLetter!.count > 0 && regexedLetter![0] == letter
    }
    
    /// 입력받은 문자열이 객체 형태인지 체크
    static func checkObjectType(letter: String) -> Bool {
        // 입력받은 문자열을 문자열 정규식에 통과시킨다
        let regexedLetter = extractRegexed(regexTry: GrammarChecker.regexObject, originLetter: letter)
        // 제대로 된 문자열이라면 입력값과 첫번째 정규식 항목과 같아야 한다
        return regexedLetter!.count > 0 && regexedLetter![0] == letter
    }
    
    /// 입력받은 문자열이 객체의 데이터 형태인지 체크
    static func checkObjectValueType(letter: String) -> Bool {
        // 입력받은 문자열을 문자열 정규식에 통과시킨다
        let regexedLetter = extractRegexed(regexTry: GrammarChecker.regexObjectValue, originLetter: letter)
        // 제대로 된 문자열이라면 입력값과 첫번째 정규식 항목과 같아야 한다
        return regexedLetter!.count > 0 && regexedLetter![0] == letter
    }
    
    /// 입력받은 문자열이 객체의 데이터 형태인지 체크
    static func checkObjectValueTypes(types: [String]) -> Bool {
        // 결과 체크용 변수
        let checkFlag = true
        // 입력받은 문자열 배열을 문자열 정규식에 통과시킨다
        for type in types {
            // 한개라도 데이터에 맞지 않으면 거짓 리턴
            guard checkObjectValueType(letter: type) == true else {
                return false
            }
        }
        return checkFlag
    }
    
}
