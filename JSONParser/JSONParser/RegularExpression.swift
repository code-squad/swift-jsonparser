//
//  RegularExpression.swift
//  JSONParser
//
//  Created by JINA on 03/01/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct RegularExpression {
    private static let typeBoolean = "(false|true)"
    private static let typeString = "\"{1}+[A-Z0-9a-z]+\"{1}"
    private static let typeNumber = "\\s[0-9]+"
    
    // 입력 문자열에서 정규식으로 문자를 추출해 배열로 리턴
    private static func matches(for regex: String, in text: String) -> [String] {
        let regex = try! NSRegularExpression(pattern: regex)
        let results = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
        return results.map { String(text[Range($0.range, in: text)!]) }
    }
    
    // 정규식의 문자열 추출 결과 확인
    private static func containsMatch(of pattern: String, inString string: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return false
        }
        let range = NSRange(string.startIndex..., in: string)
        return regex.firstMatch(in: string, options: [], range: range) != nil
    }
    
    // split 배열에서 문자열 숫자를 숫자로 형변환
    static func intCasting(text: String, regex: String) -> Int {
        let matchedRegex = matches(for: regex, in: text)
        var int = 0
        if matchedRegex[0].contains(" ") {
            int = Int(matchedRegex[0].dropFirst(1)) ?? 0
        } else {
            int = Int(matchedRegex[0]) ?? 0
        }
        return int
    }
    
    // split 배열에서 문자열 부울을 부울로 형변환
    private static func boolCasting(text: String, regex: String) -> Bool {
        let matchedRegex = RegularExpression.matches(for: regex, in: text)
        let bool = Bool(matchedRegex[0])
        return bool!
        
    }
    
    // split 배열에서 큰따옴표가 있는 문자를 찾아서 정상문자열로 만들어 반환
    private static func stringCasting(text: String, regex: String) -> String {
        let matchedRegex = RegularExpression.matches(for: regex, in: text)
        return matchedRegex[0].components(separatedBy: [" ","\""]).joined()
    }
    
    // for문으로 split을 돌면서 각 값을 jsonData에 넣어 리턴
    static func makeJsonData(split: [String]) -> JSONData {
        let data = JSONData()
        for index in split {
            if containsMatch(of: typeNumber, inString: index) {
                data.values.append(intCasting(text: index, regex: typeNumber))
            } else if containsMatch(of: typeBoolean, inString: index) {
                data.values.append(boolCasting(text: index, regex: typeBoolean))
            } else if containsMatch(of: typeString, inString: index) {
                data.values.append(stringCasting(text: index, regex: typeString))
            }
        }
        return data
    }
    
    
}
    


