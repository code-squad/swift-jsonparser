//
//  Regex.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 15..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct Regex {
    /*
     TIP
     대괄호 \\[ or \\]
     따옴표 \"
     모든문자(특수문자,공백포함) .*?
     패턴 중간 공백 제외하고 체크 [?!\\s]
     
     문자 or 숫자 or 부울 검사 : (\".*?\"|true|false|[0-9])
     띄어쓰기 \\s
     띄어쓰기가 있거나 없거나 [\\s]?
     숫자 (\\d)+
     */
    
    private static let wildcard = ".*?"
    private static let string = "\"[\\w]+\""
    private static let stringWithWildcard = "\".*?\""
    private static let int = "[0-9]+"
    private static let boolTrue = "true"
    private static let boolFalse = "false"
    private static let array = "\\[.*?\\]"
    private static let object = "\\{[\\s]?\(stringWithWildcard)[\\s]?:[\\s]?(\(stringWithWildcard)|\(int)|\(boolTrue)|\(boolFalse))[\\s]?\\}"
    private static let allValueOfArray = "(\(string)|\(int)|\(boolTrue)|\(boolFalse)|\(object)|\(array))"
    private static let allValueOfArrayWithWildCard = "(\(stringWithWildcard)|\(int)|\(boolTrue)|\(boolFalse)|\(object)|\(array))"
    
    // For GrammarChecker
    public static let numberType = "^\(int)$"
    public static let boolType = "^\(boolTrue)|\(boolFalse)*$"
    public static let objectType = "^\\{\(wildcard)\\}$"
    public static let arrayType = "^\\[\(wildcard)\\]$"
    public static let arrayPattern = "[\\s]?\\[[\\s]?([\\s]?\(allValueOfArray)\\,?[\\s]?)+[\\s]?\\][\\s]?"
    public static let objectPatternBigObject = "[\\s]?\\{[\\s]?\(string)[\\s]?:([\\s]?\(wildcard)\\,?[\\s]?)+[\\s]?\\}[\\s]?"
    
    // For Parse
    public static let objectPatternSmallObject = "[\\s]?\(string)[\\s]?:[\\s]?\(allValueOfArrayWithWildCard)[\\s]?"
    public static let objectKeyPattern = "[\\s]?\(string)[\\s]?:[\\s]?"
    public static let objectValuePattern = "[\\s]?:[\\s]?\(allValueOfArrayWithWildCard)[\\s]?"
    public static let arrayPatternSmallArray = "(\(string)|\(int)|\(boolTrue)|\(boolFalse)|\(object)|\(array))"

}
