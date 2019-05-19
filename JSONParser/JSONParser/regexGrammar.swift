//
//  regexGrammar.swift
//  JSONParser
//
//  Created by joon-ho kil on 5/14/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation


extension String {
    
    /// 문자열의 정규식 일치 여부를 확인합니다.
    ///
    /// - Parameter pattern: 정규식 패턴 문자열
    /// - Returns: true 혹은 false
    func matches(_ pattern: String) -> Bool {
        return self.range(of: pattern, options: .regularExpression) != nil
    }
    
    //정규표현식에 해당하는 문자열 배열 리턴
    func matches(for regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self,
                                        range: NSRange(self.startIndex..., in: self))
            return results.compactMap { (result) -> String? in
                guard let range = Range(result.range, in: self) else { return nil }
                return String(self[range])
            }
        } catch {
            return []
        }
    }
}


enum RegexGrammar: String {
    case object = "\\{ \"[\\d\\w' ]+\" \\: (\\[(\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\"|true|false|\\d+))*\\]|\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\" \\: (\\[(\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\"|true|false|\\d+))*\\]|\"[\\d\\w' ]+\"|true|false|\\d+)))* \\}"
    case array = "\\[ (\\[ {0,1}(\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\"|true|false|\\d+))* {0,1}\\]|\"[\\d\\w' ]+\"|true|false|\\d+|\\{ \"[\\d\\w' ]+\" \\: (\"[\\d\\w' ]+\"|true|false|\\d+)(, (\\[ {0,1}(\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\"|true|false|\\d+))* {0,1}\\]|\"[\\d\\w' ]+\" \\: (\"[\\d\\w' ]+\"|true|false|\\d+)))* \\})(, (\"[\\d\\w' ]+\"|true|false|\\d+|\\{ \"[\\d\\w' ]+\" \\: (\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\" \\: (\"[\\d\\w' ]+\"|true|false|\\d+)))* \\}))* \\]"
    case elementsFromObject = "\"[\\d\\w' ]+\" \\: (\\[(\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\"|true|false|\\d+))*\\]|\"[\\d\\w' ]+\"|true|false|\\d+)"
    case elementsFromArray = "(\\[ {0,1}(\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\"|true|false|\\d+))* {0,1}\\]|\\{ \"[\\d\\w' ]+\" \\: (\\[(\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\"|true|false|\\d+))*\\]|\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\" \\: (\\[(\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\"|true|false|\\d+))*\\]|\"[\\d\\w' ]+\"|true|false|\\d+)))* \\}|\"[\\d\\w ]+\"|true|false|\\d+)"
    case elementsFromArrayInArray = "(\\{ \"[\\d\\w' ]+\" \\: (\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\" \\: (\\[(\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\"|true|false|\\d+))*\\]|\"[\\d\\w' ]+\"|true|false|\\d+)))* \\}|\"[\\d\\w ]+\"|true|false|\\d+)"
}
