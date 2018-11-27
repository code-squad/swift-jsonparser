//
//  regularExpression.swift
//  JSONParser
//
//  Created by 김장수 on 23/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONRegex {
    private static let int = "[0-9]+", bool = "(true|false)", str = "\"[\\w_\'\\s*]+\"", blank = "\\s*"
    private static let basic = "\(str)|\(int)|\(bool)"
    
    // JSONParser 구조체에서 Parsing에 사용
    private static let keyAndValue = "\(str)\(blank):\(blank)(?:\(basic))"
    private static let array = "\\[\(blank)(?:\(basic))\(blank)(?:,\(blank)(?:\(basic))\(blank))*\\]"
    private static let object = "\\{\(blank)\(keyAndValue)\(blank)(?:,\(blank)\(keyAndValue)\(blank))*\\}"

    // 중첩 구조의 입력에서 사용
    private static let nestedKeyAndValue = "\(str)\(blank):\(blank)(?:\(basic)|\(object)|\(array))"
    private static let arrayFactor = "\(basic)|\(object)|\(array)"
    
    // GrammarCheck 구조체에서 규칙 검사에 사용
    private static let objectPattern = "^\\{\(blank)\(nestedKeyAndValue)\(blank)(?:,\(blank)\(nestedKeyAndValue)\(blank))*\\}$"
    private static let arrayPattern = "^\\[\(blank)(?:\(arrayFactor))\(blank)(?:,\(blank)(?:\(arrayFactor))\(blank))*\\]$"
    
    
    
    // 규칙 검사를 통과한 입력에서 JSONType 요소를 배열로 변환
    func extractData(from rawData: String) -> [String] {
        if rawData.isArray { return classify(rawData.removeBracket, with: JSONRegex.arrayFactor) }
        if rawData.isObject { return classify(rawData, with: JSONRegex.nestedKeyAndValue) }
        return []
    }
    
    // 입력과 정규표현식을 이용하여 배열로 분리
    private func classify(_ text: String, with pattern: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else { return [] }
        let textNS = text as NSString, rangeNS = NSRange(location: 0, length: textNS.length)
        let classified = regex.matches(in: text, options: [], range: rangeNS).map {
            textNS.substring(with: $0.range)
        }
        
        return classified
    }
    
    // 규칙 검사를 위한 메소드
    func isParsable(_ text: String) -> Bool {
        if text.isArray { return isPass(text, with: JSONRegex.arrayPattern) }
        if text.isObject { return isPass(text, with: JSONRegex.objectPattern) }
        return false
    }
    
    private func isPass(_ text: String, with pattern: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else { return false }
        let textNS = text as NSString, rangeNS = NSRange(location: 0, length: textNS.length)
        let length = regex.rangeOfFirstMatch(in: text, options: [], range: rangeNS)

        return length == rangeNS
    }
}
