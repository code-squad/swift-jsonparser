//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by hw on 28/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

extension String {
    func jsonPatternCheck(for regex: String, in inputString: String) -> [String] {
        do {
            if let regex = try? NSRegularExpression(pattern: regex, options: .caseInsensitive){
                let test = regex.matches(in: inputString, options: [], range: NSRange(location:0, length: inputString.count))
                let result : [String] = test.map{ String(inputString[Range($0.range, in: inputString)!])}
                return result
            }
        }
        //if fails
        return []
    }
}

struct GrammarChecker {
    
    private struct RegExPatternSet {
        /** Value 규칙
         * 1) true|false값은 연속되거나 부분문자로 포함되어서는 안된다. \"문자열\"의 문자열의 부분문자열로는 상관이 없다.
         * 2) value로 들어오는 문자열은 빈 문자열이어도 무방하다.
         */
        static let startSquareBracket = "^\\["
        static let endSquareBracket = "\\]$"
        static let startCurlyBracket = "^\\{"
        static let endCurlyBracket = "\\}$"
        static let blanks = "\\s*"
        static let commaBetweenBlank = "\(blanks),\(blanks)"
        static let semicolon = ":"
        static let keyString = "(\\\"[^\\\"]+\\\")"
        static let valueQuatatedString = "(\\\"[^\\\"]*\\\")"
        static let integerPattern = "([-]?[\\d]+)"
        static let integerPatternWithoutParenthesis = "[-]?[\\d]+"
        static let booleanPattern = "(true|false)"
        static let arrayPattern = "(\\[\\s*(([-]*[\\d]+)|(\\s*(\\\"[^\\\"]*\\\")\\s*)|(true|false))(((\\s*,\\s*[-]*[\\d]+)|(\\s*,\\s*(\\\"[^\\\"]*\\\")))|((\\s*,\\s*)(true|false)))*\\s*\\])"
        static let objectPattern = "(\\{\\s*((\\\"[^\\\"]+\\\")\\s*:\\s*((\\\"[^\\\"]*\\\")|([-]?[\\d]+)|(true|false)))((\\s*,\\s*)((\\\"[^\\\"]+\\\")\\s*:\\s*((\\\"[^\\\"]*\\\")|([-]?[\\d]+)|(true|false))))*\\s*\\})"
        
        /** JsonObject 규칙
         * 1) Value 규칙을 따른다.
         * 2) key로는 무조건 길이 1이상의 문자열이 와야한다.
         * 3) 숫자는 정수값을 전제하므로 음의 정수도 포함한다.
         * 4) key/value Pair의 사이나 Pair 사이에는 comma는 무조건 하나이며, 공백은 0또는 n개로 유연하게 들어간다.  CurlyBracket {의 뒤나 }의 앞의 공백여부도 마찬가지다.
         * 5) 4)의 규칙은 key와 value 사이의 semicolon에도 동일하게 적용한다.
         * 6) 반드시 {로 시작하고 ] 로 마치며, key와 value 사이에는 semicolon이 존재한다.
         * 7) 마지막 value 뒤에 comma는 존재하지 않는다.
         * 8) 정규식 패턴 검사의 결과는 단일 포맷으로 떨어진다.
         * 9) (입력문자열의 형식검증이므로) 올바르게 입력된 key 문자열의 중복을 검사하지는 않는다.
         * 10) Depth 1 규칙 : value에 중첩구조가 없는 Object나 Array가 올 수 있다.
         */
        static let firstValueOfJsonObject = "(\(keyString)\(blanks)\(semicolon)\(blanks)(\(valueQuatatedString)|\(integerPattern)|\(booleanPattern)|\(objectPattern)|\(arrayPattern)))"
        static let restValuesOfJsonObject = "((\(blanks),\(blanks))(\(keyString)\(blanks)\(semicolon)\(blanks)(\(valueQuatatedString)|\(integerPattern)|\(booleanPattern)|\(objectPattern)|\(arrayPattern))))*"
        static let jsonObjectPatternDepth1 = "\(startCurlyBracket)\(blanks)\(firstValueOfJsonObject)\(restValuesOfJsonObject)\(blanks)\(endCurlyBracket)"
        
        /** JsonArray 규칙
         * 1) Value 규칙을 따른다.
         * 2) JsonObject를 원소로 포함한다. (JsonObject를 내부 Value규칙에 포함한다.)
         * 3) Number(Int), Bool, String, JsonObject 값만 갖는다.
         * 4) value와 value 사이에 comma는 무조건 하나이며, 공백은 0또는 n개로 유연하게 들어간다. SquarBracket [의 뒤나 ]의 앞의 공백여부도 마찬가지다.
         * 5) 반드시 [로 시작하고 ]로 마친다.
         * 6) 마지막 원소 뒤에 comma는 존재하지 않는다.
         * 7) 정규식 패턴 검사의 결과는 단일 포맷으로 떨어진다.
         * 8) Depth 1 규칙 : value에 중첩구조가 없는 Object나 Array가 올 수 있다.
         */
        static let firstValueOfJsonArray = "(\(integerPattern)|(\(blanks)\(valueQuatatedString)\(blanks))|\(booleanPattern)|\(objectPattern)|\(arrayPattern))"
        static let restValuesOfJsonArray = "(((\(commaBetweenBlank)\(integerPatternWithoutParenthesis))|(\(commaBetweenBlank)\(valueQuatatedString)))|((\(commaBetweenBlank))\(booleanPattern))|(\(commaBetweenBlank)\(objectPattern))|(\(commaBetweenBlank)\(arrayPattern)))*"
        static let jsonArrayPatternDepth1 = "\(startSquareBracket)\(blanks)\(firstValueOfJsonArray)*\(restValuesOfJsonArray)\(blanks)\(endSquareBracket)"
    }
    
    static func checkJsonPattern(_ input: String) throws  {
        var result = isJsonObjectPattern(input)
        result = result ? result : isJsonArrayPattern(input)
        if !result {
            throw ErrorCode.invalidJsonFormat
        }
    }
   
    static private func isJsonArrayPattern (_ given: String) -> Bool {
        let result = given.jsonPatternCheck(for: RegExPatternSet.jsonArrayPatternDepth1, in: given).count == 1 ? true : false
        return result
    }
    
    static private func isJsonObjectPattern (_ given: String) -> Bool {
        let result = given.jsonPatternCheck(for: RegExPatternSet.jsonObjectPatternDepth1, in: given).count == 1 ? true : false
        return result
    }
}
