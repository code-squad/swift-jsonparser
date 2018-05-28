//
//  Checker.swift
//  JSONParser
//
//  Created by Yoda Codd on 2018. 5. 23..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct Checker {
    /// 인트형 타입
    static let typeInt : Int.Type = Int.self
    /// 문자형 타입
    static let typeString : String.Type = String.self
    /// Bool 타입
    static let typeBool : Bool.Type = Bool.self
    /// 객체형 타입
    private static let emptyObject : [String:Any] = [:]
    static let typeObject = type(of: emptyObject)
    
    
    /// 문자열을 받아서 JSON 문자형인지 체크
    static func isLettersForJSON(letter : String) -> Bool {
        // 문자열의 첫번쨰와 마지막이 " 이면 참
        return letter[letter.startIndex] == JSON.letterWrapper && letter[letter.index(before:letter.endIndex)] == JSON.letterWrapper
    }
    
    /// 문자열을 받아서 JSON 객체의 문자형인지 체크
    static func checkObjectForJSON(letter : String) -> Bool {
        // 문자열의 첫번쨰와 마지막이 " 이면 참
        return letter[letter.startIndex] == JSON.startOfObjectOfJSON && letter[letter.index(before:letter.endIndex)] == JSON.endOfObjectOfJSON
    }
    
    /// 문자열을 받아서 JSON 배열의 문자형인지 체크
    static func checkArrayForJSON(letter : String) -> Bool {
        // 문자열의 첫번쨰와 마지막이 " 이면 참
        return letter[letter.startIndex] == JSON.startOfArrayOfJSON && letter[letter.index(before:letter.endIndex)] == JSON.endOfArrayOfJSON
    }
    
    /// JSON 배열 데이터중 입력받은 자료형 타입이 몇개인지 리턴
    static private func countType(targetType : Any.Type, dataArray: [Any]) -> Int {
        // 결과값 변수 선언
        var countOfLetter = 0
        // JSON 배열을 반복문에 넣는다
        for data in dataArray {
            if ObjectIdentifier(type(of: data)) == ObjectIdentifier(targetType) {
                countOfLetter += 1
            }
        }
        return countOfLetter
    }
    
    /// JSON 객체 데이터중 입력받은 자료형 타입이 몇개인지 리턴
    static private func countType(targetType : Any.Type, dataObject: [String:Any]) -> Int {
        // 결과값 변수 선언
        var countOfLetter = 0
        // JSON 배열을 반복문에 넣는다
        for data in dataObject.values {
            if ObjectIdentifier(type(of: data)) == ObjectIdentifier(targetType) {
                countOfLetter += 1
            }
        }
        return countOfLetter
    }
    // 타겟이 배열인 경우
    /// 입력한 배열에 인트형이 몇개인지 리턴
    static func countIntFrom(targetArray : [Any]) -> Int {
        return countType(targetType: Checker.typeInt, dataArray: targetArray)
    }
    
    /// 입력한 배열에 인트형이 몇개인지 리턴
    static func countStringFrom(targetArray : [Any]) -> Int {
        return countType(targetType: Checker.typeString, dataArray: targetArray)
    }
    
    /// 입력한 배열에 인트형이 몇개인지 리턴
    static func countBoolFrom(targetArray : [Any]) -> Int {
        return countType(targetType: Checker.typeBool, dataArray: targetArray)
    }
    
    /// 입력한 배열에 인트형이 몇개인지 리턴
    static func countObjectFrom(targetArray : [Any]) -> Int {
        return countType(targetType: Checker.typeObject, dataArray: targetArray)
    }
    // 타겟이 객체인 경우
    /// 입력한 객체에 인트형이 몇개인지 리턴
    static func countIntFrom(targetObject : [String:Any]) -> Int {
        return countType(targetType: Checker.typeInt, dataObject: targetObject)
    }
    
    /// 입력한 객체에 인트형이 몇개인지 리턴
    static func countStringFrom(targetObject : [String:Any]) -> Int {
        return countType(targetType: Checker.typeString, dataObject: targetObject)
    }
    
    /// 입력한 객체에 인트형이 몇개인지 리턴
    static func countBoolFrom(targetObject : [String:Any]) -> Int {
        return countType(targetType: Checker.typeBool, dataObject: targetObject)
    }
    
    
}
