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
    private static func object() -> String { return "\\{[\\s]?\(stringWithWildcard)[\\s]?:[\\s]?(\(stringWithWildcard)|\(int)|\(boolTrue)|\(boolFalse))[\\s]?\\}" }
    private static func allValueOfArray() -> String { return "(\(string)|\(int)|\(boolTrue)|\(boolFalse)|\(object())|\(array))" }
    private static func allValueOfArrayWithWildCard() -> String { return "(\(stringWithWildcard)|\(int)|\(boolTrue)|\(boolFalse)|\(object())|\(array))" }
    
    // For GrammarChecker
    public static func isNumber() -> String { return "^\(int)$" }
    public static func isBool() -> String { return "^\(boolTrue)|\(boolFalse)*$" }
    public static func isObject() -> String { return "^\\{\(wildcard)\\}$" }
    public static func isArray() -> String { return "^\\[\(wildcard)\\]$" }
    public static func arrayPattern() -> String { return "[\\s]?\\[[\\s]?([\\s]?\(allValueOfArray())\\,?[\\s]?)+[\\s]?\\][\\s]?" }
    public static func objectPatternBigObject() -> String { return "[\\s]?\\{[\\s]?\(string)[\\s]?:([\\s]?\(wildcard)\\,?[\\s]?)+[\\s]?\\}[\\s]?" }
    
    // For Parse
    public static func objectPatternSmallObject() -> String { return "[\\s]?\(string)[\\s]?:[\\s]?\(allValueOfArrayWithWildCard())[\\s]?" }
    public static func objectKeyPattern() -> String { return "[\\s]?\(string)[\\s]?:[\\s]?" }
    public static func objectValuePattern() -> String { return "[\\s]?:[\\s]?\(allValueOfArrayWithWildCard())[\\s]?" }
    public static func arrayPatternSmallArray() -> String { return "(\(string)|\(int)|\(boolTrue)|\(boolFalse)|\(object())|\(array))" }
    
}
